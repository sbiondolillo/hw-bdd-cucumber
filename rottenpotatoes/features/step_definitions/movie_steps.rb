# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    new_movie = Movie.new
    new_movie.title = movie['title']
    new_movie.rating = movie['rating']
    new_movie.release_date = movie['release_date']
    new_movie.save!
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  expect(page.body.index(e1)).to be < page.body.index(e2)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I check the following ratings: (.*)/ do |fields|
  selected = fields.split(",")
  selected.each do |field|
    check("ratings_#{field}")
  end
end

When /I uncheck the following ratings: (.*)/ do |fields|
  unselected = fields.split(",")
  unselected.each do |field|
    uncheck("ratings_#{field}")
  end
end

Then /I should see all the movies/ do
  rows = page.all('table#movies tr').count
  expect(rows).to eq 11
end
