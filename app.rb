require "bundler/setup"


get '/' do
  erb :index
end

# Sube objeto a cluster
get '/fileUpload' do
  erb :fileUpload
end

get '/listObject' do
  erb :listObject
end

get '/pf' do
  erb :fu
end

get '/status' do
  erb :status
end

post '/upload' do
  user_bucket     = 'NICO'
  file       = params[:file][:tempfile]
  filename   = params[:file][:filename]
  AWS::S3::Base.establish_connection!(
    :server            => 'ceph.autentia.cl',
    :access_key_id     => 'ZYSIEXK5Q13052Y2D2EO',
    :secret_access_key => 'DuEBOfP6AIItsnXYRvTDCRdGTV80ObIdMHrq6Mzm',
    :bucket            => user_bucket
  )
  AWS::S3::S3Object.store(
    filename,
    open(file.path),
    bucket,
    :access => :public_read
  )
  url = "https://#{bucket}.ceph.autentia.cl/#{filename}"
  return url
end
