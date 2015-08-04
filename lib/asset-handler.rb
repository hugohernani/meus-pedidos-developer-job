class AssetHandler < Sinatra::Base
  configure do
    set :root, File.expand_path('../../',__FILE__)
    set :views, File.expand_path('../../assets', __FILE__)
    enable :coffeescript
    set :coffeedir, 'coffee'
    set :jsdir, 'js'
    set :cssdir, 'css'
    set :cssengine, 'scss'
  end

  get '/coffee/*.js' do
    pass unless settings.coffeescript?
    last_modified File.mtime(settings.root + '/assets/' + settings.coffeedir)
    cache_control :public, :must_revalidate
    coffee (settings.coffeedir + '/' + params[:splat].first).to_sym
  end

  get '/css/*.css' do
    last_modified File.mtime(settings.root + '/assets/' + settings.cssdir)
    cache_control :public, :must_revalidate
    send(settings.cssengine, (settings.cssdir + '/' + params[:splat].first).to_sym)
  end

end
