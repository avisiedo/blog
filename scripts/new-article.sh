#!/bin/bash

# see: https://docs.getpelican.com/en/latest/content.html

ARTICLE_TITLE="My super title"
ARTICLE_DATE_CREATED="$(date "+%Y-%m-%d %H:%M")"
ARTICLE_DATE_MODIFIED="${ARTICLE_DATE_CREATED}"
ARTICLE_CATEGROY=""
ARTICLE_TAGS=""
ARTICLE_SLUG=""
ARTICLE_AUTHORS="Alejandro Visiedo"
ARTICLE_SUMMARY=""
ARTICLE_HEAD_COVER="static/cover-header.jpg"
ARTICLE_STATUS="draft"  # hidden, skip, published

transform_title_to_slug() {
  local input_string="$*"
  echo "${input_string}" | tr '[:upper:]' '[:lower:]' | tr -s ' ' '-' | sed 's/[^a-z0-9]/-/g'
}

prompt_title() {
  echo -n "Title for your new article: "
  read -r ARTICLE_TITLE
  ARTICLE_SLUG="$(transform_title_to_slug "${ARTICLE_TITLE}")"
}

prompt_category() {
  echo -n "Category: "
  read ARTICLE_CATEGROY
}

prompt_tags() {
  echo -n "Tags: "
  read -r ARTICLE_TAGS
}

prompt_slug() {
  echo -n "Slug[${ARTICLE_SLUG}]: "
  read value
  [ "${value}" != "" ] || value="${ARTICLE_SLUG}"
  ARTICLE_SLUG="${value}"
}

prompt_authors() {
  echo -n "Authors[${ARTICLE_AUTHORS}]: "
  read value
  [ "${value}" != "" ] || value="${ARTICLE_AUTHORS}"
  ARTICLE_AUTHORS="${value}"
}

prompt_summary() {
  echo "Below write your summary and press CTRL+D when you finish"
  cat > /tmp/summary.txt 
  ARTICLE_SUMMARY="$( cat /tmp/summary.txt )"
}

prompt_data() {
  prompt_title
  prompt_category
  prompt_tags
  prompt_slug
  prompt_authors
  prompt_summary
}

prompt_confirmation() {
  local value
  echo -n "$* (y/N)? "
  read value
  [ "${value}" == "y" ] || [ "${value}" == "Y" ]
}

generate_new_article() {
  cat <<EOF
---
Title: ${ARTICLE_TITLE}
Date: ${ARTICLE_DATE_CREATED}
Modified: ${ARTICLE_DATE_MODIFIED}
Category: ${ARTICLE_CATEGROY}
Tags: ${ARTICLE_TAGS}
Slug: ${ARTICLE_SLUG}
Authors: ${ARTICLE_AUTHORS}
Summary: ${ARTICLE_SUMMARY}
Header_Cover: ${ARTICLE_HEAD_COVER}
---
# ${ARTICLE_TITLE}

This is the content of my super blog post.
EOF
}

main() {
  prompt_data
  FILENAME="$(date "+%Y-%m-%d")--${ARTICLE_SLUG}.md"
  generate_new_article
  if prompt_confirmation "Confirm article creation"; then
    generate_new_article > "content/${FILENAME}"
  else
    echo "Cancelled"
  fi
}

main
