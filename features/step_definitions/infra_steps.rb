Cuando('pido \/version') do
  @responce = Faraday.get(get_url_for('/version'))
end

Entonces('obtengo la version app') do
  expect(@responce.status).to be == 200
  expect(JSON.parse(@responce.body)['version']).to eq Version.current
end
