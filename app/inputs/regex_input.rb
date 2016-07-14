class RegexInput < SimpleForm::Inputs::StringInput
  def input
    format('</br>').html_safe + "／ " + super + " ／"
  end
end
