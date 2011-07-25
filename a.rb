#!/usr/bin/env ruby

username = ARGV[0]
password = ARGV[1]

require 'rubygems'
require 'bundler'
require 'mechanize'

a = Mechanize.new
page = a.get('http://aws.amazon.com/account/')
p = a.page.links.find { |l| l.text == 'Account Activity' }.click
login_form = p.form('signIn')
login_form.email = username
login_form.password = password
p = a.submit(login_form, login_form.buttons.first)

# puts p.content
td = p.search('td.padbot5').select { |b| b.content.include? 'Current estimated unpaid balance' }.first
value =  td.parent.css('td.alignrt').first.content
value.gsub!(/\s+/, '')
value.gsub!('$', '')
value.gsub!(',', '')
puts value.to_f