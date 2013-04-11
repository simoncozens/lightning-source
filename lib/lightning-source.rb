require "mechanize"

class LightningSource
	exceptions = %w[ Login Internal ]  

	exceptions.each { |e| const_set(e+"Error", Class.new(StandardError)) }  

	VERSION = "1.0"
	attr_accessor :agent

  def initialize(login, password)
  	@agent = Mechanize.new
  	@agent.user_agent_alias = 'Mac Safari'
  	login_page = @agent.get("https://www.lightningsource.com/LSISecure/Login.aspx")
  	f = login_page.form
  	f.field_with(:name => "login:txtLogin").value = login
  	f.field_with(:name => "login:txtPassword").value = password
  	page = agent.submit(f,f.buttons.first)
  	if page.search(".formError").count > 0
  		raise LightningSource::LoginError
  	end
  	if !@agent.cookies.find {|x| x.name == "LSISecureSessionID" }
  		raise LightningSource::InternalError
  	end
  end

  def compensation(options = {})
  	market = options[:market] == "UK" ? 1 : 0
  	currency = market == 0 ? 2 : 0
  	page = @agent.get("https://www.lightningsource.com/LSISecure/FinancialReports/PubCompReportCriteria.aspx")
  	f = page.form
  		f.field_with(:name => "_ctl0:MainContent:PeriodEntry:txtDate1").value = options[:first].strftime("%d-%b-%y")
  		f.field_with(:name => "_ctl0:MainContent:PeriodEntry:txtDate2").value = options[:last].strftime("%d-%b-%y")
  		f.checkbox_with(:name => "_ctl0:MainContent:optOrgID:"+market.to_s).check
  		f.checkbox_with(:name => "_ctl0:MainContent:optCurrency:"+currency.to_s).check
  		f.checkbox_with(:name => "_ctl0:MainContent:optCompensationType:0").check
  	report = agent.submit(f, f.buttons.first)
  	# Do some checks here
  	table = reformat_table(report)
  	table.shift
  	headers = table.shift
  	# Convert to an array of hashes
  	table.map {|row|
  		h = Hash[*headers.map{|x|x.gsub(/\s+/,"").to_sym}.zip(row).flatten]
      nh = {}
      h.each do |k,v|
        if k == :ISBN or k == :Title or k == :Author
          nh[k] = v
        elsif k == :Disc
          nh[k] = v.to_f/100
        else
          nh[k] = v.to_f
        end
      end
      nh
    }
  end

  private

  def reformat_table(page)
  	return page.search("tr").map {|t| 
  		t.search("td").map{|x| x.content}
  	}
  end
end
