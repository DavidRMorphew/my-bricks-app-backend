castle_themes_nums = [25, 186, 187, 188, 189, 190, 191, 193, 194, 195, 196, 197, 198, 199, 201, 202, 203, 211, 255]
space_theme_nums = [93, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 144, 146, 452, 527]
classic_town_nums = [68, 69, 70, 71, 72, 73, 74, 76, 77, 78, 79, 80, 82, 83, 85]
pirate_themes_nums = [147, 148, 149, 151, 152, 153, 154, 215]

# Select which Lego themes you would like to use to add to the database.

# For Castle themes, uncomment the following:
    # castle_themes_nums.each do |theme_num|
    #     Api.fetch_sets_by_theme_num(theme_num)
    # end
    
# For Space themes, uncomment the following:
    # space_theme_nums.each do |theme_num|
    #     Api.fetch_sets_by_theme_num(theme_num)
    # end
    
# For Classic Town themes, uncomment the following:
    # classic_town_nums.each do |theme_num|
    #     Api.fetch_sets_by_theme_num(theme_num)
    # end
    
# For Pirate themes, uncomment the following:
    # pirate_themes_nums.each do |theme_num|
    #     Api.fetch_sets_by_theme_num(theme_num)
    # end

# For All themes and sets, uncomment the following:
    # Api.fetch_all_themes
    # all_theme_nums = Theme.all.map{|theme| theme.theme_number}
    # all_theme_nums.each do |theme_num|
    #     Api.fetch_sets_by_theme_num(theme_num)
    # end