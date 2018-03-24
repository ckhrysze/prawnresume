require "prawn"

information = {
  bio: {
    title: "Chris Hildebrand",
    extra_info: %w(773.357.5655 christopher@chrishildebrand.net)
  },
  skills: {
    languages: %w(Python Ruby Elixir Javascript Go PHP C# Elm),
    frameworks: %w(Rails Django Phoenix Sinatra Flask Vue ReactNative),
    systems: %w(AWS Docker Ubuntu OSX Windows),
    databases: %w(Postgresql MongoDB Couchbase Mysql Redis)
  },
  experience: {
    label: "Experience",
    positions: [
      {
        title: "Director of Engineering  @  Advanced Health Communications",
        duration: "Dec 2016 - present",
        points: [
          "- Led team responsible for design, development and deployment",
          "- Worked with owners to create the company's product roadmap",
          "- Architected and implemented message search and routing algorithms"
        ]
      },
      {
        title: "Lead Software Engineer  @  Scientific Games Corporation",
        duration: "Jan 2013 - Nov 2016",
        points: [
          "- Mentored peers across several products and technologies",
          "- Worked with stakeholders to design and develop productivity tools",
          "- Developed product features and built AWS architecture",
          "- Coordinated tasks between local and remote teams"
        ]
      },
      {
        title: "Software Consultant  @  Iron Ninja Technologies",
        duration: "6 week contract Jun 2016 - Jul 2016",
        points: [
          "- Designed, setup, and deployed all aspects of server architecture",
          "- Led the team creating the product API and underlying model structure",
          "- Built a robust data generation tool for integration testing",
        ]
      },
      {
        title: "Software Engineer  @  Trustwave Holdings",
        duration: "May 2011 - Jan 2013",
        points: [
          "- Integrated Spider Labs security tools into a cohesive product",
          "- Created an automated regression framework",
          "- Trained and led a small team"
        ]
      },
      {
        title: "Software Developer  @  Business Logic Corporation",
        duration: "Jan 2006 - May 2011",
        points: [
          "- Designed and implemented a custom CMS application",
          "- Deployed, tested and maintained several live applications",
          "- Worked with financial experts to implement analytical algorithms",
          "- Mentored and trained new developers"
        ]
      },
      {
        title: "Software Developer  @  Digonex Technologies",
        duration: "Oct 2003 - Dec 2005",
        points: [
          "- Worked with designers to renovate website",
          "- Integrated projects with third party services and programs"
        ]
      }
    ]
  },
  education: {
    name: "Rose-Hulman Institute of Technology",
    degree: "Bachelor of Science, Computer Science"
  }
}


def write_bio(bio)
  space = ' ' * 10
  font_size(18) {
    text(bio[:title], align: :center)
  }
  font_size(8) {
    text(bio[:extra_info].join(space), align: :center)
  }
end

def write_skills(skills)
  sub_section_gap = 5

  skills.each_with_index do |(section, values), index|
    font_size(10) {
      text(section.to_s.capitalize)
    }
    top = bounds.top - ((sub_section_gap + font_size) * index)
    bounding_box([CONTENT_X, top], width: CONTENT_WIDTH) do
      font_size(10) {
        text(values.join(", "))
      }
    end
    move_down sub_section_gap
  end
end

def write_experience(experience)
  sub_section_gap = 15
  text(experience[:label])

  bounding_box([CONTENT_X, bounds.top], width: CONTENT_WIDTH) do
    title_opts = {style: :bold}
    date_opts = {size: 10, style: :italic}

    experience[:positions].each do |position|
      text(position[:title], title_opts)
      text(position[:duration], date_opts)
      position[:points].each { |point| text(point) }
      move_down sub_section_gap
    end
  end
end

def write_education(education)
  text("Education")
  bounding_box([CONTENT_X, bounds.top], width: CONTENT_WIDTH) do
    text(education[:name], style: :bold)
    text(education[:degree])
  end
end

Prawn::Document.generate("resume.pdf") do

  CONTENT_X = 100
  WIDTH = bounds.right
  CONTENT_WIDTH = WIDTH - CONTENT_X
  SECTION_GAP = 22

  bounding_box([0, cursor], width: WIDTH) do
    write_bio(information[:bio])
  end

  move_down SECTION_GAP
  bounding_box([0, cursor], width: WIDTH) do
    write_skills(information[:skills])
  end

  move_down SECTION_GAP
  bounding_box([0, cursor], width: WIDTH) do
    write_experience(information[:experience])
  end

  move_down SECTION_GAP
  bounding_box([0, cursor], width: WIDTH) do
    write_education(information[:education])
  end

end
