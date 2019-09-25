def production_suitable_seeds
  gsa = Organization.create!({
    name: "General Services Administration",
    abbreviation: "GSA",
    domain: "gsa.gov",
    url: "https://gsa.gov"
  })
  puts "Created Organization: #{gsa.name}"
end

production_suitable_seeds

# Seeds below are intended for
#   Staging and Development Environments; not Production.
return false if Rails.env.production?

example_gov = Organization.create!({
  name: "Example.gov",
  domain: "example.gov",
  url: "https://example.gov",
  abbreviation: "EX"
})
puts "Created Default Organization: #{example_gov.name}"

# Create Seeds
admin_user = User.new({
  organization: example_gov,
  email: "admin@example.gov",
  password: "password",
  admin: true
})
admin_user.save!
puts "Created Admin User: #{admin_user.email}"

digital_gov = Organization.create!({
  name: "Digital.gov",
  domain: "digital.gov",
  url: "https://digital.gov",
  abbreviation: "DIGITAL"
})
puts "Creating additional Organization: #{digital_gov.name}"

program_1 = Program.create!({
  name: "Program 1 for Digital.gov",
  organization: digital_gov,
  url: "https://digital.gov/program-name"
})
program_2 = Program.create!({
  name: "Program 2 for Digital.gov",
  organization: digital_gov,
  url: "https://digital.gov/program-name-2"
})

org_2 = Organization.create!({
  name: "Farmers.gov",
  domain: "example.gov",
  url: "https://farmers.gov",
  abbreviation: "FARMERS"
})
program_3 = Program.create!({
  name: "Program 3 for Farmers.gov",
  organization: org_2,
  url: "https://farmers.gov/program-name-3"
})

org_3 = Organization.create!({
  name: "Cloud.gov",
  domain: "cloud.gov",
  url: "https://cloud.gov",
  abbreviation: "CLOUD"
})

webmaster = User.new({
  email: "webmaster@example.gov",
  password: "password",
  organization: example_gov
})
webmaster.save!
puts "Created #{webmaster.email}"

organization_manager = User.new({
  email: "organization_manager@example.gov",
  password: "password",
  organization: example_gov,
  organization_manager: true
})
organization_manager.save!
puts "Created #{organization_manager.email}"

service_manager = User.new({
  email: "service_manager@example.gov",
  password: "password",
  organization: example_gov
})
service_manager.save!
puts "Created #{service_manager.email}"

submission_viewer = User.new({
  email: "viewer@example.gov",
  password: "password",
  organization: example_gov
})
submission_viewer.save!
puts "Created #{submission_viewer.email}"

# Form Templates
form_1 = FormTemplate.create({
  name: "Open-ended",
  kind:  "open-ended",
  title: "Custom Open-ended Title",
  instructions: "Share feedback about the new example.gov website and recommend additional features.",
  disclaimer_text: "Disclaimer Text Goes Here",
  notes: ""
})

form_2 = FormTemplate.create({
  name: "Recruiter",
  kind:  "recruiter",
  title: "",
  instructions: "",
  disclaimer_text: "Disclaimer Text Goes Here",
  notes: ""
})

form_3 = FormTemplate.create({
  name: "À11 - 7 Question Form",
  kind:  "a11",
  title: "",
  instructions: "",
  disclaimer_text: "Disclaimer Text Goes Here",
  notes: ""
})

form_4 = FormTemplate.create({
  name: "Open Ended Form with Contact Information",
  kind:  "open-ended-with-contact-info",
  title: "",
  instructions: "",
  disclaimer_text: "Disclaimer Text Goes Here",
  notes: ""
})

# Forms
form_1 = Form.create({
  name: "Open-ended",
  kind:  "open-ended",
  title: "Custom Open-ended Title",
  instructions: "Share feedback about the new example.gov website and recommend additional features.",
  disclaimer_text: "Disclaimer Text Goes Here",
  notes: "",
  character_limit: 6000
})

form_2 = Form.create({
  name: "Recruiter",
  kind:  "recruiter",
  title: "",
  instructions: "",
  disclaimer_text: "Disclaimer Text Goes Here",
  notes: ""
})

form_3 = Form.create({
  name: "À11 - 7 Question Form",
  kind:  "a11",
  title: "",
  instructions: "",
  disclaimer_text: "Disclaimer Text Goes Here",
  notes: ""
})

form_4 = Form.create({
  name: "Open Ended Form with Contact Information",
  kind:  "open-ended-with-contact-info",
  title: "",
  instructions: "",
  disclaimer_text: "Disclaimer Text Goes Here",
  notes: "",
  character_limit: 6000
})

custom_form = Form.create({
  name: "Custom Form",
  kind:  "custom",
  title: "",
  instructions: "",
  disclaimer_text: "Disclaimer Text Goes Here",
  success_text: "Thank you for your submission 🎉",
  notes: "",
  character_limit: 1000
})

Question.create!({
  form: custom_form,
  text: "Custom Question Text Field",
  question_type: "text_field",
  position: 1,
  answer_field: :answer_01,
  is_required: false,
})

Question.create!({
  form: custom_form,
  text: "Custom Question Text Area",
  question_type: "textarea",
  position: 2,
  answer_field: :answer_02,
  is_required: false,
})

radio_button_question = Question.create!({
  form: custom_form,
  text: "Custom Question Radio Buttons",
  question_type: "radio_buttons",
  position: 3,
  answer_field: :answer_03,
  is_required: false,
})

QuestionOption.create!({
  question: radio_button_question,
  text: "Option 1",
  position: 1
})

QuestionOption.create!({
  question: radio_button_question,
  text: "Option 2",
  position: 2
})

QuestionOption.create!({
  question: radio_button_question,
  text: "Option 3",
  position: 3
})

# A Service created by Admin
service_1  = Service.create!({
  organization: example_gov,
  name: "Test Service 1"
})
UserService.create(
  user: admin_user,
  service: service_1,
  role: UserService::Role::ServiceManager
)

# A 2nd Service created by Admin
service_2  = Service.create!({
  organization: example_gov,
  name: "Test Service 2"
})
UserService.create(
  user: admin_user,
  service: service_2,
  role: UserService::Role::ServiceManager
)

# A Service created by Webmaster
service_3  = Service.create!({
  organization: digital_gov,
  name: "Test Service 3"
})
UserService.create(
  user: webmaster,
  service: service_3,
  role: UserService::Role::ServiceManager
)
# Submission Viewer can view the Admin's Service
UserService.create(
  user: submission_viewer,
  service: service_2,
  role: UserService::Role::SubmissionViewer
)

# A Service created by Admin in another Organization
service_4  = Service.create!({
  organization: org_2,
  name: "Test Service 4 (for Farmers.gov)"
})
UserService.create(
  user: admin_user,
  service: service_4,
  role: UserService::Role::ServiceManager
)


# Touchpoints
touchpoint_1 = Touchpoint.create!({
  form: form_1,
  service: service_1,
  name: "Open-ended Feedback",
  purpose: "Soliciting feedback",
  meaningful_response_size: 30,
  behavior_change: "Looking for opportunities to improve",
  notification_emails: "ryan.wold@gsa.gov"
})

touchpoint_2 = Touchpoint.create!({
  form: form_2,
  service: service_1,
  name: "Recruiter",
  purpose: "Improving Customer Experience with proactive research and service",
  meaningful_response_size: 100,
  behavior_change: "We will use the this feedback to inform Product and Program decisions",
  notification_emails: "ryan.wold@gsa.gov"
})

touchpoint_3 = Touchpoint.create!({
  form: form_3,
  service: service_2,
  name: "A11 - 7 question test - DB",
  purpose: "CX",
  meaningful_response_size: 100,
  behavior_change: "Better customer service",
  notification_emails: "ryan.wold@gsa.gov"
})

touchpoint_4 = Touchpoint.create!({
  form: form_4,
  service: service_2,
  name: "A11 - 7 question test - DB",
  purpose: "CX",
  meaningful_response_size: 100,
  behavior_change: "Better customer service",
  notification_emails: "ryan.wold@gsa.gov"
})

Submission.create!({
  touchpoint: touchpoint_1,
  answer_01: "Body text"
})

Submission.create!({
  touchpoint: touchpoint_1,
  answer_01: "Another body text " * 20
})

Submission.create!({
  touchpoint: touchpoint_2,
  answer_01: "Mary",
  answer_02: "Public",
  answer_03: "public_user_3@example.com",
  answer_04: "5555550000"
})

# TODO: Seed A11
# Submission.create!({
#   touchpoint: touchpoint_3
# })


digital_gov_user = User.new({
  email: "user@digital.gov",
  password: "password"
})
digital_gov_user.save!
puts "Created Test User in Secondary Organization: #{digital_gov_user.email}"

## Generate admin
admin_emails = ENV.fetch("TOUCHPOINTS_ADMIN_EMAILS").split(",")
admin_emails.each do |email|
  User.new({
    email: email.strip,
    password: SecureRandom.hex,
    admin: true
  }).save!
end

pra_contact = PraContact.create!({
  email: "pra_contact@example.gov",
  name: "Rosa Parks"
})
puts "Created PRA Contact User for Primary Organization: #{pra_contact.email}"
