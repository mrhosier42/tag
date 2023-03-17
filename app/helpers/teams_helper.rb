module TeamsHelper
  # def any_question_not_always_or_most_of_the_time?(survey, question_keys)
  #   question_keys.any? do |key|
  #     survey[key] && survey[key] != "Always" && survey[key] != "Most of the time"
  #   end
  # end
  #
  # def evaluate_and_style(value)
  #   if value != "Always" && value != "Most of the time"
  #     "text-white bg-danger"
  #   else
  #     ""
  #   end
  # end
  #
  # def evaluation_css_class(result)
  #   if result != "Always" && result != "Most of the time"
  #     "text-white bg-danger"
  #   else
  #   ""
  #   end
  # end
  #
  #
  # def navigation_link(index, direction, team, sprint, semester)
  #   if direction == 'left' && index == 0
  #     index = -1
  #   elsif direction == 'right' && index.nil?
  #     index = 0
  #   end
  #
  #   path = semester_team_path(semester, team: team, sprint: sprint)
  #   icon_name = direction == 'double' ? "chevron-double-#{direction}" : "chevron-#{direction}"
  #   title = "#{direction} #{index.nil? ? 'sprint' : 'team'}"
  #
  #   link_to path do
  #     image_tag "#{icon_name}.svg", class: "", style: "height:48px", title: title
  #   end
  # end

  def name1
    puts 'hello'
  end

end
