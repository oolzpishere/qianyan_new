Uploader::Engine.routes.draw do
  post 'push/:form_identify/:pass_token', to: 'push#push_datum', module: 'uploader'
end
