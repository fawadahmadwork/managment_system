ActiveAdmin.register Employee do
  form do |f|
    f.inputs do
      f.input :first_name, as: :string, input_html: { style: 'text-transform: capitalize;' }
      f.input :last_name, as: :string, input_html: { style: 'text-transform: capitalize;' }
      f.input :date_of_birth, as: :datepicker, datepicker_options: {
        changeMonth: true,
        changeYear: true,
        yearRange: '1970:2008'

      }, input_html: { id: 'date-of-birth' }
      f.input :age, input_html: { id: 'age' }
      f.input :gender, as: :select, collection: %w[Male Female]

      f.input :national_id_card, length: { maximum: 15 },
                                 input_html: {
                                   placeholder: 'i-e 12345-1234567-1', class: 'national-id-input'
                                 }
      f.input :employment_type, as: :select,
                                collection: %w[FullTime PartTime Contractor Internee]
      f.input :department, as: :select,
                           collection: ['Development', 'Quality Assurance'],
                           input_html: { id: 'employee_department' }

      f.input :designation, as: :select,
                            collection: [],
                            input_html: { id: 'employee_designation' }

      f.input :employment_status, as: :select,
                                  collection: %w[Active Inactive Freeze], id: 'employment-status-select'

      f.input :freezing_date, as: :datepicker, id: 'freezing-date-input'
      f.input :freezing_comment, as: :text, id: 'freezing-comment-input'

      f.input :date_of_joining, as: :datepicker, datepicker_options: { changeYear: true, yearRange: '2015:c' }

      if f.object.new_record?

        f.input :termination_date, as: :datepicker, label: false, input_html: { style: 'display: none;' }
      else

        f.input :termination_date, as: :datepicker
      end
      f.input :avatar, as: :file,
                       hint: f.object.avatar.attached? ? image_tag(f.object.avatar.variant(resize: '150x150')) : ''
      f.input :address, as: :text
      f.input :notes

      f.has_many :emails, allow_destroy: true do |email_form|
        email_form.input :email
      end
      f.has_many :phone_numbers, allow_destroy: true do |phone_form|
        phone_form.input :phone_number,
                         input_html: { placeholder: '0300-1234567', pattern: '\d{4}-\d{7}',
                                       id: 'phone_number_input_id' }
      end
    end
    f.has_many :bank_account_details, allow_destroy: true do |bank_account_form|
      bank_account_form.input :bank_name
      bank_account_form.input :account_title
      bank_account_form.input :branch_code,
                              input_html: { placeholder: 'Enter a 4-digit branch code' }
      bank_account_form.input :account_number, input_html: {
        placeholder: 'Please enter a 16-digit account number'
      }
      bank_account_form.input :IBAN, input_html: {
        pattern: 'PK\d{2}[A-Za-z]{4}\d{16}',
        placeholder: ' (e.g., PK36SCBL0000001123456702)'
      }
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column 'Full Name', sortable: :last_name do |employee|
      "#{employee.first_name} #{employee.last_name}"
    end
    column :age
    column :gender
    column :designation
    column :department
    actions
  end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :gender
      row :age
      row :date_of_birth
      row :email do |employee|
        if employee.emails.any?
          employee.emails.first.email
        else
          'N/A'
        end
      end
      row :phone_number do |employee|
        if employee.phone_numbers.any?
          employee.phone_numbers.first.phone_number
        else
          'N/A'
        end
      end
      row :address
      row :national_id_card
      row :employment_type
      row :department
      row :designation
      row :employment_status
      if employee.employment_status == 'Freeze'
        row :freezing_date if resource.freezing_date.present?
        row :freezing_comment if resource.freezing_comment.present?
      end
      row :date_of_joining
      row :termination_date if resource.termination_date.present?
      row :notes
      row :avatar do |employee|
        if employee.avatar.attached?
          image_tag url_for(employee.avatar), height: '100px', width: '100px'
        else
          'N/A'
        end
      end

      panel 'Emails' do
        table_for employee.emails do
          column :email
        end
      end
      panel 'Phone Numbers' do
        table_for employee.phone_numbers do
          column :phone_number
        end
      end
      panel 'Bank Account Details' do
        table_for employee.bank_account_details do
          column :bank_name
          column :branch_code
          column :account_title
          column :account_number
          column :IBAN
        end
      end
    end

    panel 'Salary Structures' do
      if employee.salary_structure.present?
        attributes_table_for employee.salary_structure do
        end

        div do
          link_to 'View Salary Structure', admin_salary_structure_path(employee.salary_structure), class: 'button'
        end

        div style: 'margin-top: 10px;' do
          link_to 'View Salary Detail Histories',
                  admin_salary_detail_histories_path(q: { salary_structure_id_eq: employee.salary_structure.id }),
                  class: 'button'
        end
      else
        div do
          link_to 'Create Salary Structure', new_admin_salary_structure_path(employee_id: employee.id), class: 'button'
        end
      end
    end
    panel 'Salary Slips' do
      if employee.salary_slips.present?
        div style: 'margin-top: 10px;' do
          link_to 'View Salary Slips', admin_salary_slips_path(q: { employee_id_eq: employee.id }), class: 'button'
        end
      else
        div style: 'margin-top: 10px;' 'No salary slips available.'
      end
      div style: 'margin-top: 10px;' do
        link_to 'Create New Salary Slip', new_admin_salary_slip_path(employee_id: employee.id), class: 'button'
      end
    end

    active_admin_comments
  end

  controller do
    def new
      @employee = Employee.new
      @employee.phone_numbers.build
      @employee.emails.build
      @employee.bank_account_details.build
    end
  end

  permit_params :first_name, :last_name, :age, :gender, :date_of_birth, :address, :national_id_card,
                :designation, :department, :date_of_joining, :termination_date, :avatar, :notes, :employment_status, :employment_type, :freezing_date, :freezing_comment,
                emails_attributes: %i[id email _destroy],
                phone_numbers_attributes: %i[id phone_number _destroy],
                bank_account_details_attributes: %i[id account_title account_number bank_name branch_code IBAN _destroy]
end
