require 'httparty'
require 'faker'
response = HTTParty.post("http://localhost:3000/users.json", body: {
		user:  {
				email:  Faker::Internet.free_email,
				password:  "secret123",
				password_confirmation:  "secret123"}
		
	}.to_json, headers: {"Content-Type" => "application/json"})

puts response