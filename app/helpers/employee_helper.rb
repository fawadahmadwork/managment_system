# app/helpers/employee_helper.rb
module EmployeeHelper
  def designation_options(selected_department)
    # Define the designation options based on the selected department
    if selected_department == 'Development'
      ['Intern', 'L1 Software Engineer', 'L2 Software Engineer - L3']
    elsif selected_department == 'Quality Assurance'
      ['InternSQA', 'Senior SQA']
    else
      [''] # Default option when no department is selected
    end
  end
end
