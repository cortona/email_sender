# 📧 Ruby Email Sender 🚀

## Overview 🌟
A powerful and flexible Ruby script for sending HTML emails via SMTP with robust configuration and error handling.

## Features ✨
- 🔐 Secure SMTP configuration
- 🌈 Flexible environment-based settings
- 💻 Command-line interface support
- 🛡️ Comprehensive error handling
- 🔧 Easy customization

## Prerequisites 📋
- Ruby 2.7+ 💎
- Bundler gem 📦

## Installation 🛠️

1. Clone the repository:
```bash
git clone https://github.com/cortona/email_sender.git
cd email_sender
```

2. Install dependencies:
```bash
bundle install
```

3. Create a `.env` file with your SMTP credentials:
```bash
SMTP_FROM_EMAIL=sender@example.com
SMTP_TO_EMAIL=recipient@example.com
SMTP_USERNAME=your_username
SMTP_PASSWORD=your_password
SMTP_HOST=smtp.yourprovider.com
SMTP_PORT=587
```

## Usage 🚀

### Basic Usage
```bash
ruby email_sender.rb -t recipient@example.com -s "Hello!" -b body.html
```

### Options 🔍
- `-f, --from EMAIL`: Sender email address
- `-t, --to EMAIL`: Recipient email address
- `-s, --subject SUBJECT`: Email subject
- `-b, --body HTML_FILE`: Path to HTML body file

## Environment Variables 🔐

| Variable | Description | Default |
|----------|-------------|---------|
| `SMTP_FROM_EMAIL` | Sender's email | **Required** |
| `SMTP_TO_EMAIL` | Recipient's email | **Required** |
| `SMTP_SUBJECT` | Default email subject | "Test Email" |
| `SMTP_HOST` | SMTP server address | "localhost" |
| `SMTP_PORT` | SMTP server port | 25 |
| `SMTP_AUTHENTICATION` | SMTP auth method | "login" |
| `SMTP_ENABLE_STARTTLS` | Enable STARTTLS | true |

## Error Handling 🚨
- Validates required email configuration
- Provides clear error messages
- Graceful failure with exit codes

## Contributing 🤝
1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License 📄
Distributed under the MIT License. See `LICENSE` for more information.

## Contact 📬
Martin - m.schneider@cortona.de

Project Link: [https://github.com/cortona/email_sender](https://github.com/cortona/email_sender)

Made with ❤️ and Ruby 💎
