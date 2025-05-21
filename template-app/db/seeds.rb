# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create(email: 'intern.app@yopmail.com', password: 'Password@123', password_confirmation: 'Password@123') unless AdminUser.find_by_email('intern.app@yopmail.com')
BxBlockTermsAndConditions::TermsAndCondition.find_or_create_by(account_type: "Intern")
BxBlockTermsAndConditions::TermsAndCondition.find_or_create_by(account_type: "Business")
BxBlockTermsAndConditions::PrivacyPolicy.find_or_create_by(account_type: "Intern")
BxBlockTermsAndConditions::PrivacyPolicy.find_or_create_by(account_type: "Business")
threshold = Threshold.first
unless threshold.present?
	Threshold.find_or_create_by!(threshold_percentage: 50)
end
questions = BxBlockSurveys::BusinessUserGenericQuestion.all
unless questions.present?
	BxBlockSurveys::BusinessUserGenericQuestion.find_or_create_by(question: "What does the intern need to have?", hint: "Requirements for the intern", title: "Requirements")
	BxBlockSurveys::BusinessUserGenericQuestion.find_or_create_by(question: "What will be the intern recieve?", hint: "Benefits for the intern", title: "Benefits")
	BxBlockSurveys::BusinessUserGenericQuestion.find_or_create_by(question: "What kind of skills will the intern develop?", hint: "Skill development opportunities", title: "Skills Development")
	BxBlockSurveys::BusinessUserGenericQuestion.find_or_create_by(question:"How will you mentor and support the intern?", hint: "Mentorship and support_provided", title: "Mentorship and Support")
end

schedule_codes = ["part_time", "full_time"]
location_codes = ["remote", "in_person", "hybrid"]

schedule_codes.each do |s_code|
	schedule = BxBlockSettings::WorkSchedule.find_or_create_by(code: s_code)
	schedule.icon.attach(io: File.open("app/assets/images/#{s_code}.png"), filename: "#{s_code}.png", content_type: "image/png") unless schedule.icon.attached?
end

location_codes.each do |l_code|
	location = BxBlockSettings::WorkLocation.find_or_create_by(code: l_code)
	location.icon.attach(io: File.open("app/assets/images/#{l_code}.png"), filename: "#{l_code}.png", content_type: "image/png") unless location.icon.attached?
end

interncharacteristic_skills = ['Technical Skills', 'Soft Skills and Attributes', 'Education and Knowledge', 'Experience and Projects']

if BxBlockSurveys::InternCharacteristic.all.count < 4
	interncharacteristic_skills.each do |skill|
		characterstic = BxBlockSurveys::InternCharacteristic.find_or_create_by(name: skill)
	end
end

prompt_manager = BxBlockChat::PromptManager.first

if prompt_manager.nil?
  prompt_manager = BxBlockChat::PromptManager.create(criteria: "Behavioral Interview Analyst
You are a Behavioral Interview Analysis Specialist responsible for evaluating and summarizing chat-based interviews with interns. Your expertise lies in extracting insights from the interview text, providing structured feedback, and offering detailed performance assessments.
Core Responsibilities:
•    Interview Text Analysis: Carefully analyze the written responses provided by interns during the interview, focusing on clarity, tone, and content relevance.
•    Summary of the Interview: Generate a concise yet comprehensive summary of the interview, highlighting key points, strengths, and areas for improvement. This summary provides a quick reference for hiring managers.
•    Scoring System: Assign scores out of 10 for each key topic covered during the interview, including:
o    Problem-solving approach and critical thinking
o    Adaptability to new challenges and environments
o    Communication clarity and tone
o    Handling feedback and constructive criticism
o    Emotional intelligence and self-awareness
o    Collaboration and teamwork mindset
o    Conflict resolution and stress management
o    Motivation and long-term career goals
o    Time management and organizational skills
o    Decision-making under pressure
o    Initiative and proactivity in tasks
o    Accountability and ownership of responsibilities
•    Performance Analysis: Provide a detailed analysis of the intern's performance based on their scores, identifying patterns, strengths, and weaknesses in their responses. This analysis helps clarify how well the candidate aligns with the role requirements.
•    Suggestions for Improvement: Offer targeted suggestions for each topic where the intern may have underperformed. This could include strategies for improving communication skills, enhancing emotional intelligence, or developing better time management techniques.
Interview Analysis Style: You approach the analysis with a balanced perspective, focusing on both quantitative and qualitative insights. Your scoring system provides a clear framework for evaluation, while your summaries and suggestions are designed to be constructive and actionable.")
	prompt_manager.prompt_versions.create!(name: "Prompt Version 1", description: prompt_manager.criteria)
end

subscription_setting = BxBlockSubscriptionBilling::Subscription.first
if subscription_setting.nil?
	BxBlockSubscriptionBilling::Subscription.create(title: "From April 2025 subscription plan price will be increase by 3%/Month.", amount: 505)
end
