# encoding: utf-8

namespace "branches" do

    desc "Update all slugs on branches"
    task fix_slug: :environment do
      puts "#{Time.now}: Begin Fixing branches slug"

      fix_letters = [
        {'á' => 'a'}, {'é' => 'e'}, {'í' => 'i'}, {'ó' => 'o'}, {'ú' => 'u'},
        {'Á' => 'A'}, {'É' => 'E'}, {'Í' => 'I'}, {'Ó' => 'O'}, {'Ú' => 'U'},
        {'ñ' => 'n'}, {'Ñ' => 'N'},

        {' ' => '-'}, {'_' => '-'},
      ]

      ActiveRecord::Base.transaction do
        branch = Branch.find_each do | branch |
        s = "#{branch.slug}-#{branch.name}}"

        # Removes non standar characters
        fix_letters.map{|pattern| s.gsub!(pattern.keys.first, pattern.values.first)}

        # Removes non-alphanumeric
        s = s.gsub(/[^0-9a-z\- ]/i, '-')

        # Removes extra -
        s = s.gsub(/\-+/,'-')

        # Downcase
        s.downcase!

        branch.slug = s

        puts branch.slug

        branch.save

        end
      end

      puts "#{Time.now}: End Fixing branches slug"
  end

end
