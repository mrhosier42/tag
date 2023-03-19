module TeamsHelper

  # def check_for_not_always_most_of_the_time(*keys)
  #   keys.any? do |key|
  #     s[key] && s[key] != "Always" && s[key] != "Most of the time"
  #   end
  # end

  # Check any response for each team member
  def some_condition?(s, key)
    s[key] && s[key] != "Always" && s[key] != "Most of the time"
  end

  def display_table_row(title, columns)
    content_tag(:tr) do
      concat(content_tag(:th, title))
      columns.each do |key, value|
        concat(content_tag(:td, value, class: some_class(key, value)))
      end
    end
  end

  def some_class(key, value)
    if value != "Always" && value != "Most of the time"
      "text-white bg-danger"
    else
      ""
    end
  end

  def display_survey_data(s)
    output = ""
    6.times do |i|
      index = i + 1
      output += "<tr>
      <th>Attends group meetings and arrives on time</th>
      <td class='#{danger_class(s[:q11_1])}'>#{s[:q11_1]}</td>
      <td class='#{danger_class(s[:q21_1])}'>#{s[:q21_1]}</td>
      #{conditional_td(s, index, :q15_1)}
      #{conditional_td(s, index, :q16_1)}
      #{conditional_td(s, index, :q25_1)}
    </tr>
    <tr>
      <th>Does high quality work</th>
      <td class='#{danger_class(s[:q11_2])}'>#{s[:q11_2]}</td>
      <td class='#{danger_class(s[:q21_2])}'>#{s[:q21_2]}</td>
      #{conditional_td(s, index, :q15_2)}
      #{conditional_td(s, index, :q16_2)}
      #{conditional_td(s, index, :q25_2)}
    </tr>
    <tr>
      <th>Completes their work on time</th>
      <td class='#{danger_class(s[:q11_3])}'>#{s[:q11_3]}</td>
      <td class='#{danger_class(s[:q21_3])}'>#{s[:q21_3]}</td>
      #{conditional_td(s, index, :q15_3)}
      #{conditional_td(s, index, :q16_3)}
      #{conditional_td(s, index, :q25_3)}
    </tr>
    <tr>
      <th>Does a fair share of the team's work</th>
      <td class='#{danger_class(s[:q11_4])}'>#{s[:q11_4]}</td>
      <td class='#{danger_class(s[:q21_4])}'>#{s[:q21_4]}</td>
      #{conditional_td(s, index, :q15_4)}
      #{conditional_td(s, index, :q16_4)}
      #{conditional_td(s, index, :q25_4)}
    </tr>
    <tr>
      <th>Communicates effectively and respectfully with their teammates</th>
      <td class='#{danger_class(s[:q11_5])}'>#{s[:q11_5]}</td>
      <td class='#{danger_class(s[:q21_5])}'>#{s[:q21_5]}</td>
      #{conditional_td(s, index, :q15_5)}
      #{conditional_td(s, index, :q16_5)}
      #{conditional_td(s, index, :q25_5)}
    </tr>
    <tr>
      <th>Choose one additional category</th>
      #{conditional_td(s, index, :q11_6_text, :q11_6)}
      #{conditional_td(s, index, :q21_6_text, :q21_6)}
      #{conditional_td(s, index, :q15_6_text, :q15_6)}
      #{conditional_td(s, index, :q16_6_text, :q16_6)}
      #{conditional_td(s, index, :q25_6_text, :q25_6)}
    </tr>"
    end
  end


end
