require 'rubygems'
require 'hpricot'
require 'cgi'
require 'open-uri'

class SemanticHacker

  URL = "http://api.semantichacker.com"
  attr_accessor :token, :doc, :content

  def initialize(token)
    @token = token
  end

  def get_signature(content)
    @content = ::CGI::escape(content)
    url = "#{URL}/#{@token}/signature?content=#{@content}"
    @doc = Hpricot.XML(open(url))
  end

  def get_concepts(content)
    @content = ::CGI::escape(content)
    url = "#{URL}/#{@token}/concept?content=#{@content}"
    @doc = Hpricot.XML(open(url))
  end

  def get_categories(content)
    @content = ::CGI::escape(content)
    url = "#{URL}/#{@token}/category?content=#{@content}"
    @doc = Hpricot.XML(open(url))
  end

  def type
    (doc/:response/:about/:systemType).inner_html
  end

  def config_id
    (doc/:response/:about/:configId).inner_html
  end

  def categories
    response = []
    (doc/:response/:categorizer/:categorizerResponse/:categories/:category).each do |item|
      response << {:id => item.attributes['id'], :weight => item.attributes['weight']}
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
      response << {:index => item.attributes['index'], :weight => item.attributes['weight']}
    end
    response
  end

end

