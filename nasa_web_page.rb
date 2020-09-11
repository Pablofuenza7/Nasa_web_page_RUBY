require 'uri'
require 'net/http'
require 'json'
require 'openssl' 

def request(url_requested)
    url = URI(url_requested)
    http = Net::HTTP.new(url.host, url.port)

    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    
    request = Net::HTTP::Get.new(url)
    request["cache-control"] = 'no-cache'
    
    response = http.request(request)
    JSON.parse response.read_body
end


def build_web_page(test)

    html = ""
    
    f = File.new('index.html', 'w')
    f.write("<html>\n")
    f.write("<head>\n")
    f.write("</head>\n")
    f.write("<body>\n")
    f.write("<ul>\n")



    test['photos'].each do |i|
        i.each do |k, v|
          if k == 'img_src'
            html += ("<li><img src=\"#{v}\"></li>\n")
          end
    File.write('index.html',html)

        end


    end
    
    f.write("</ul>\n")
    f.write("</body>\n")
    f.write("</html>\n")    
    f.close

   
end

data = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=fNCrLqXdQ0Qz9FhLonr9kIdx3ARngwhm133HBXpX")
data = data["photos"]
build_web_page(data)

