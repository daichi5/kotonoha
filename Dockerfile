FROM ruby:2.6.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs libappindicator1 fonts-liberation libappindicator3-1 libasound2 libnspr4 libnss3 libxss1 xdg-utils
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && apt-get install -y nodejs build-essential && npm install -g phantomjs-prebuilt
RUN npm install -g yarn
RUN rm -rf /var/lib/apt/lists/*
RUN curl -O https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb

RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp
