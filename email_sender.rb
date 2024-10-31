#!/usr/bin/env ruby
# frozen_string_literal: true

require 'debug'
require 'dotenv/load'
require 'mail'
require 'optparse'

class EmailSender
  def initialize
    @config = load_config
  end

  def send_email(options = {})
    # Merge default configuration with passed options
    email_config = @config.merge(options)

    # Validate required fields
    validate_config!(email_config)

    # Configure SMTP settings
    Mail.defaults do
      delivery_method :smtp, {
        address: email_config[:smtp_host],
        port: email_config[:smtp_port],
        user_name: email_config[:smtp_username],
        password: email_config[:smtp_password],
        authentication: email_config[:smtp_authentication],
        enable_starttls_auto: email_config[:smtp_enable_starttls]
      }
    end

    # Send the email
    Mail.deliver do
      from     email_config[:from]
      to       email_config[:to]
      subject  email_config[:subject]
      body     email_config[:html_body]
      
      content_type 'text/html; charset=UTF-8'
    end

    puts "Email sent successfully to #{email_config[:to]}"
  rescue => e
    puts "Email sending failed: #{e.message}"
  end

  private

  def load_config
    # Default configuration from environment variables
    {
      from: ENV.fetch('SMTP_FROM_EMAIL') { raise ArgumentError, "SMTP_FROM_EMAIL not set" },
      to: ENV.fetch('SMTP_TO_EMAIL') { raise ArgumentError, "SMTP_TO_EMAIL not set" },
      subject: ENV.fetch('SMTP_SUBJECT', 'Test Email'),
      html_body: ENV['SMTP_HTML_BODY'],
      smtp_host: ENV.fetch('SMTP_HOST', 'localhost'),
      smtp_port: ENV.fetch('SMTP_PORT', 25).to_i,
      smtp_username: ENV.fetch('SMTP_USERNAME') { raise ArgumentError, "SMTP_USERNAME not set" },
      smtp_password: ENV.fetch('SMTP_PASSWORD') { raise ArgumentError, "SMTP_PASSWORD not set" },
      smtp_authentication: ENV.fetch('SMTP_AUTHENTICATION', 'login').to_sym,
      smtp_enable_starttls: ENV.fetch('SMTP_ENABLE_STARTTLS', 'true') == 'true'
    }
  end

  def validate_config!(config)
    # Validate HTML body
    raise ArgumentError, "HTML body cannot be empty" if config[:html_body].nil?
  end
end

# Command-line interface
if __FILE__ == $PROGRAM_NAME
  options = {}
  
  OptionParser.new do |opts|
    opts.banner = "Usage: email_sender.rb [options]"

    opts.on("-f", "--from EMAIL", "Sender email address") do |v|
      options[:from] = v
    end

    opts.on("-t", "--to EMAIL", "Recipient email address") do |v|
      options[:to] = v
    end

    opts.on("-s", "--subject SUBJECT", "Email subject") do |v|
      options[:subject] = v
    end

    opts.on("-b", "--body HTML_FILE", "Path to HTML file") do |v|
      options[:html_body] = File.read(v)
    end
  end.parse!

  begin
    sender = EmailSender.new
    sender.send_email(
      {
        from: options[:from],
        to: options[:to],
        subject: options[:subject],
        html_body: options[:html_body]
      }.compact
    )
  rescue ArgumentError => e
    puts "Error: #{e.message}"
    exit 1
  end
end
