require "prawn"

information = {
  bio: {
    title: "Chris Hildebrand",
    extra_info: %w(773.357.5655 christopher@chrishildebrand.net)
  },
  skills: {
    languages: %w(Python Ruby Elixir Javascript Go PHP C# C++ Java Elm),
    frameworks: %w(Rails Django Phoenix Sinatra Grape Flask),
    systems: %w(AWS Docker Ubuntu OSX Windows),
    databases: %w(Postgresql Mysql MongoDB Couchbase Redis)
  },
  experience: {
    label: "Experience",
    positions: [
      {
        title: "Lead Software Engineer  @  Scientific Games Corporation",
        duration: "Jan 2013 - Nov 2016",
        points: [
          "- Led and mentored peers across several products and technologies",
          "- Worked with stakeholders to design and develop productivity tools",
          "- Created games with flexible rule sets",
          "- Developed product features and built architecture",
          "- Coordinated tasks with remote offices"
        ]
      },
      {
        title: "Software Engineer  @  Trustwave Holdings",
        duraction: "Jan 2011 - Jan 2013",
        points: [
          "- Integrated security tools into a cohesive product",
          "- Created an automated regression framework",
          "- Worked closely with teams in Spider Labs",
          "- Trained and led a small team"
        ]
      },
      {
        title: "Software Developer  @  Business Logic Corporation",
        duraction: "Jan 2006 - May 2011",
        points: [
          "- Designed and implemented a custom CMS application",
          "- Created an API for external programs",
          "- Deployed, tested and maintained several live applications",
          "- Worked with financial experts to implement analytical algorithms",
          "- Directed several applications through the product life cycle",
          "- Mentored and trained new developers"
        ]
      },
      {
        title: "Software Developer  @  Digonex Technologies",
        duraction: "Oct 2003 - Dec 2005",
        points: [
          "- Designed and built multiple systems using Java web solutions",
          "- Created several applications to automate testing",
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
  font_size(24) {
    text(bio[:title], align: :center)
  }
  font_size(8) {
    text(bio[:extra_info].join(space), align: :center)
  }
end

def write_skills(skills)
  puts skills
  sub_section_gap = 5

  skills.each_with_index do |(section, values), index|
    text(section.to_s.capitalize)
    top = bounds.top - ((sub_section_gap + font_size) * index)
    bounding_box([CONTENT_X, top], width: CONTENT_WIDTH) do
      text(values.join(", "))
    end
    move_down sub_section_gap
  end
end

def write_experience(experience)
  sub_section_gap = 20
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
  SECTION_GAP = 35

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
