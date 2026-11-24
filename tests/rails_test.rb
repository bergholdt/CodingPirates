# Kør med APP_DIR sat til én start- eller facitmappe, i testmiljø.
ENV['RAILS_ENV'] = 'test'
require 'pathname'
root = Pathname.new(ENV.fetch('APP_DIR')).expand_path
require root.join('config/environment')
Rails.application.load_tasks
Rake::Task['db:prepare'].invoke
require 'rails/test_help'

class PiratkursusTest < ActionDispatch::IntegrationTest
  def database_lesson?
    Rails.root.to_s.include?('05-faelles-logbog')
  end

  def solution?
    Rails.root.basename.to_s == 'facit'
  end

  setup { Entry.delete_all if database_lesson? }

  test 'forside og sundhedskontrol svarer' do
    get '/'
    assert_response :success
    get '/up'
    assert_response :success
  end

  test 'flaskepost viser formular med navne og labels' do
    get '/flaskepost'
    assert_response :success
    assert_select 'form[method=post]'
    assert_select 'input[name=pirat]'
    assert_select 'textarea[name=tekst]'
    assert_select 'label[for=pirat]'
  end

  test 'flaskepost virker eller viser den forventede starterfejl' do
    post '/flaskepost', params: { pirat: 'Kaptajn Ø', tekst: '<b>Skat!</b>' }
    if solution? || database_lesson?
      assert_response :success
      assert_includes response.body, '&lt;b&gt;Skat!&lt;/b&gt;'
      assert_includes response.body, 'Kaptajn Ø'
    else
      assert_response :unprocessable_entity
    end
  end

  test 'flaskepost afviser mellemrum og for lange tekster' do
    [{pirat: '  ', tekst: 'Skat'}, {pirat: 'A', tekst: 'x' * 281}].each do |params|
      post '/flaskepost', params: params
      assert_response :unprocessable_entity
    end
  end

  test 'forkert CSRF-token afvises når beskyttelsen er slået til' do
    old = FlaskepostController.allow_forgery_protection
    FlaskepostController.allow_forgery_protection = true
    post '/flaskepost', params: {pirat: 'Krabbe', tekst: 'Skat', authenticity_token: 'forkert'}
    assert_response :unprocessable_entity
    assert_includes response.body, 'InvalidAuthenticityToken' 
  ensure
    FlaskepostController.allow_forgery_protection = old
  end

  test 'modellen afviser tomme og lange indlæg' do
    skip "Kun gang 5" unless database_lesson?
    assert_not Entry.new(pirat: ' ', tekst: 'Hej').valid?
    assert_not Entry.new(pirat: 'P' * 25, tekst: 'Hej').valid?
    assert_not Entry.new(pirat: 'P', tekst: 'T' * 281).valid?
    assert Entry.new(pirat: 'Ø' * 24, tekst: 'Æ' * 280).valid?
  end

  test 'gemning redirecter og en GET laver ikke en ekstra række' do
    skip "Kun gang 5" unless database_lesson?
    post '/entries', params: {entry: {pirat: 'Krabbe', tekst: 'Fandt guld'}}
    if solution?
      assert_response :see_other
      assert_equal 1, Entry.count
      follow_redirect!
      assert_includes response.body, 'Fandt guld'
      get '/entries'
      assert_equal 1, Entry.count
      # En anden browsersession ser samme data.
      another = open_session
      another.get '/entries'
      assert_includes another.response.body, 'Fandt guld'
    else
      assert_response :unprocessable_entity
      assert_equal 0, Entry.count
    end
  end

  test 'ugyldig formular bevarer input uden at gemme' do
    skip "Kun gang 5" unless database_lesson?
    post '/entries', params: {entry: {pirat: 'Krabbe', tekst: ' '}}
    assert_response :unprocessable_entity
    assert_equal 0, Entry.count
    assert_select 'input[value=Krabbe]'
  end

  test 'kun tilladte felter gemmes og output escapes' do
    skip "Kun facit i gang 5" unless database_lesson? && solution?
    post '/entries', params: {entry: {pirat: '<b>P</b>', tekst: '<script>alert(1)</script>', id: 999999}}
    follow_redirect!
    assert_not_equal 999999, Entry.last.id
    assert_includes response.body, '&lt;script&gt;alert(1)&lt;/script&gt;'
    assert_select 'script', count: 0
  end

  test 'listen viser højst 50 indlæg i omvendt rækkefølge' do
    skip "Kun facit i gang 5" unless database_lesson? && solution?
    51.times { |i| Entry.create!(pirat: 'Pirat', tekst: "Eventyr #{i}") }
    get '/entries'
    assert_select 'li', count: 50
    assert_select 'li:first-child', text: 'Pirat: Eventyr 50'
    assert_select 'li:last-child', text: 'Pirat: Eventyr 1'
  end
end
