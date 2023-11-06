# syntax=docker/dockerfile:1
FROM ruby:3.2.2

# Install dependencies for the operating system software
# Including the Nginx for the reverse proxy
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client nginx

# Install the specific version of Bundler that matches the Gemfile.lock
RUN gem install bundler:2.2.22

# Setup the working directory
WORKDIR /myapp

# Copying Nginx configuration
COPY nginx.conf /etc/nginx/sites-available/nginx.conf
RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/nginx.conf \
    && rm -f /etc/nginx/sites-enabled/default

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install -y yarn

# Install Ruby dependencies
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# Install JavaScript dependencies
COPY package.json /myapp/package.json
COPY yarn.lock /myapp/yarn.lock
RUN yarn install --check-files

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["/usr/bin/entrypoint.sh"]

# Expose ports for the Nginx server
EXPOSE 80

