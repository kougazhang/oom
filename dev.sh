#!/usr/bin/env sh

lessc ./less/hux-blog.less ./css/hux-blog.css
lessc -x ./less/hux-blog.less ./css/hux-blog.min.css
bundle exec jekyll serve