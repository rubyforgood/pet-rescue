# Use the official Ruby image as a base
FROM ruby:3.3.0-slim

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  postgresql-client \
  build-essential \
  libpq-dev \
  chromium-driver

# Set up working directory
WORKDIR /myapp

# Copy Gemfile and Gemfile.lock before other files to leverage Docker's caching mechanism
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# Install gems
RUN gem install bundler && bundle install

# Copy the rest of the application code
COPY . /myapp

# Precompile assets (optional for development, but useful for production)
RUN bundle exec rails assets:precompile

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

# Expose port 3000 to the Docker host
EXPOSE 3000

# Start the Rails server
ENTRYPOINT ["entrypoint.sh"]
CMD ["rails", "server", "-b", "0.0.0.0"]
