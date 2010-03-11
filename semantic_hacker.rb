require 'rubygems'
require 'hpricot'
require 'cgi'
require 'open-uri'


class SemanticHacker

  URL = "http://api.semantichacker.com"
  attr_accessor :token, :doc, :content, :content_type, :content
  attr_reader :api_call

  def initialize(token)
    @token = token
    @signatures = YAML::load(File.open(File.join(File.dirname(__FILE__), 'db/signatures.yml')).read)
  end

  def query_for(content_type, content)
    @content_type = content_type   # uri or content
    @content = sanitize(content)
    self
  end

  def get_signatures
    @api_call = "#{URL}/#{@token}/signature?#{@content_type}=#{@content}"
    @doc = Hpricot.XML(open(@api_call))
    signatures
  end

  def get_concepts
    @api_call = "#{URL}/#{@token}/concept?#{@content_type}=#{@content}"
    @doc = Hpricot.XML(open(@api_call))
    concepts
  end

  def get_categories
    @api_call = "#{URL}/#{@token}/category?#{@content_type}=#{@content}&showLabels=true"
    @doc = Hpricot.XML(open(@api_call))
    categories
  end


  private

  def type
    (doc/:response/:about/:systemType).inner_html
  end


  def config_id
    (doc/:response/:about/:configId).inner_html
  end


  def categories
    response = []
    (doc/:response/:categorizer/:categorizerResponse/:categories/:category).each do |item|
      response << {:label => item.attributes['label'], :weight => item.attributes['weight']}
    end
    response
  end

  def concepts
    response = []
    (doc/:response/:conceptExtractor/:conceptExtractorResponse/:concepts/:concept).each do |item|
      response << {:label => item.attributes['label'], :weight => item.attributes['weight']}
    end
    response
  end

  def signatures
    response = []
    (doc/:response/:siggen/:siggenResponse/:signature/:dimension).each do |item|
      response << {:index => item.attributes['index'], :weight => item.attributes['weight'], :label => @signatures[item.attributes['index']]}
    end
    response
  end
  
  def sanitize(content)
    if @content_type == :uri
      return content
    else
      return ::CGI::escape(content)
    end
  end
  
end

