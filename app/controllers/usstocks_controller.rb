class UsstocksController < ApplicationController

  def index
    @usstocks = Usstock.all
  end

  def new
    @usstock = Usstock.new
  end

  def create
    @usstock = Usstock.new(usstock_params)
    @usstock.save
    response = RestClient.get "http://web.juhe.cn:8080/finance/stock/usa", :params => {:gid => @usstock.juhe_gid, :key => "1f2211355c59fc686e6af04159f76e82"}
    data = JSON.parse(response.body)
    data["result"].each do |c|
      @usstock = Usstock.update(:juhe_gid => c["data"]["gid"], :name => c["data"]["name"],
                      :lastestpri => c["data"]["lastestpri"], :openpri => c["data"]["openpri"],
                      :formpri => c["data"]["formpri"], :limit => c["data"]["limit"],
                      :uppic => c["data"]["uppic"], :priearn => c["data"]["priearn"],
                      :beta => c["data"]["beta"], :chtime => c["data"]["chtime"])
    end
    redirect_to usstock_path(@usstock)
  end

  def show
    @usstock = Usstock.find(params[:id])
  end

  private

  def usstock_params
    params.require(:usstock).permit(:juhe_gid)
  end
end
