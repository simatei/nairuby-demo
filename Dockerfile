# syntax=docker/dockerfile:1
FROM ruby:3.2.2

# Install dependencies for the operating system software
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Install the specific version of Bundler that matches the Gemfile.lock
RUN gem install bundler:2.2.22

WORKDIR /myapp
COPY config/webpacker.yml /myapp/config/webpacker.yml

# Install Ruby dependencies
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update && apt-get install -y yarn

# Install JavaScript dependencies
COPY package.json /myapp/package.json
COPY yarn.lock /myapp/yarn.lock
RUN yarn install --check-files

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
