# -*- coding: utf-8 -*-

require 'json'
require 'mechanize'

class UrlExtractor

  @agent = nil
  @page = nil

  def initialize(url)
    @agent = Mechanize.new
    @page = @agent.get(url)
  end

  def title()
    title = @page.at('meta[@property="og:title"]/@content')
    return title.inner_text() if title && !title.inner_text.empty?

    title = @page.at('title')
    return title.inner_text() if title && !title.inner_text.empty?
    
    title = @page.at('h1')
    return title.inner_text() if title && !title.inner_text.empty?

    return first_text()
  end

  def description()
    desc = @page.at('meta[@property="og:description"]/@content')
    return desc.inner_text() if desc && !desc.inner_text.empty?

    desc = most_punctuated_text()
    return desc if desc && !desc.empty?

    desc = @page.at('meta[@name="description"]/@content')
    return desc.inner_text() if desc && !desc.inner_text.empty?

    return first_text()
  end

  def first_text()
    @page.search('div/p').each_with_index{|elem, i|
      text = elem.inner_text()
      return text if text && !text.empty?
    }
  end

  def most_punctuated_text()
    punctuated_count = {}
    @page.search('div/p').each_with_index{|elem, i|
      text = elem.inner_text()
      punctuation_marks_count = text.scan(/,|.|、|。/).size
      punctuated_count.store(text, punctuation_marks_count)
    }

    punctuated_count.sort_by{|key, value| -value}.each {|key, value|
      return key
    }
  end

  def images()
    host = @page.uri.host
    images = []
    @page.images.each{|image|
      next if !image.url.host.include?(host)
      images.push(image.url.scheme.to_s + image.url.host.to_s + image.url.path.to_s)
    }

    return images.uniq
  end

  def to_json
    return JSON.generate({title: title(), description: description(), images: images()})
  end

end

app = UrlExtractor.new(ARGV[0])

puts app.to_json


