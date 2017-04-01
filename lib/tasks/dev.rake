namespace :dev do
  task :fetch_stock => :environment do
    puts "Fetch stock data..."
    response = RestClient.get "http://web.juhe.cn:8080/finance/stock/usa", :params => {:gid => "aapl", :key => JUHE_CONFIG["api_key"]}
    data = JSON.parse(response.body)

    data["result"].each do |c|
      existing_stock = Usstock.find_by_juhe_gid(c["data"]["gid"])
      if existing_stock.nil?
        Usstock.create!(:juhe_gid => c["data"]["gid"], :name => c["data"]["name"],
                        :lastestpri => c["data"]["lastestpri"], :openpri => c["data"]["openpri"],
                        :formpri => c["data"]["formpri"], :limit => c["data"]["limit"],
                        :uppic => c["data"]["uppic"], :priearn => c["data"]["priearn"],
                        :beta => c["data"]["beta"], :chtime => c["data"]["chtime"])
      end
      puts "#{Usstock.last.name}(#{Usstock.last.juhe_gid})'s data is fetched"
    end
  end
end
