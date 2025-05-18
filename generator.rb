require "prawn"
require "prawn/icon"

information = {
  bio: {
    title: "Chris Hildebrand",
    extra_info: [
      '<icon>mdi-phone</icon>773.213.0780',
      '<icon>mdi-web</icon>https://chrishildebrand.net',
      '<icon>mdi-email-open</icon>chris@chrishildebrand.net'
]
  },
  skills: {
    languages: %w(Elixir Python Bash Ruby Javascript PHP C# Java),
    frameworks: %w(Phoenix LiveView Terraform TailwindCSS Flask Sinatra),
    systems: %w(GCP AWS Docker Debian Ubuntu OSX Windows),
    databases: %w(PostgreSQL Mnesia MongoDB Couchbase)
  },
  experience: {
    page_one: {
      label: "Experience",
      positions: [
        {
          title: "Senior Director of Product Reliability  @  Versus Systems",
          duration: "Jun 2018 - present",
          points: [
            "- Created and maintained infrastructure for seven Elixir applications",
            "- Designed and built the data and analytics pipeline for four products",
            "- Reduced hosting costs by over 60% while increasing uptime",
            "- Managed and mentored developers, QA team and Devops team",
            "- Worked with executive team on product roadmap and company culture"
          ]
        },
        {
          title: "Director of Engineering  @  Advanced Health Communications",
          duration: "Dec 2016 - Jun 2018",
          points: [
            "- Managed the company software engineering team",
            "- Worked directly with owners to create the product roadmap",
            "- Led effort to migrate database from MongoDB to PostgreSQL",
            "- Architected and implemented HL7 parsing, search and routing algorithms"
          ]
        },
        {
          title: "Freelance Elixir Developer  @  multiple clients",
          duration: "~ 6 years",
          points: [
            "- Migrated discrete game theory simulations into a single platform",
            "- Added automatic language detection and internationalization support",
            "- Built financial portfolio app that tracked stocks and crypto assets",
            "- Transformed large pdf catalog into searchable topic summaries"
          ]
        },
        {
          title: "Lead Software Engineer  @  Scientific Games Corporation",
          duration: "Jan 2013 - Nov 2016",
          points: [
            "- Mentored peers across several products and technologies",
            "- Worked with stakeholders to design and develop productivity tools",
            "- Supervised team creating a new game engine",
            "- Developed product features and built AWS architecture",
            "- Coordinated tasks between local and remote teams"
          ]
        }
      ]
    },
    page_two: {
      label: "Experience (cont)",
      positions: [
        {
          title: "Software Engineer  @  Trustwave Holdings",
          duration: "May 2011 - Jan 2013",
          points: [
            "- Integrated Spider Labs security tools into a cohesive product",
            "- Created automated regression framework",
            "- Trained and led a small team"
          ]
        },
        {
          title: "Software Developer  @  Business Logic Corporation",
          duration: "Jan 2006 - May 2011",
          points: [
            "- Designed and implemented a custom CMS application",
            "- Deployed, tested and maintained live applications",
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
    }
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
  font_size(9) {
    #icon 'fas-beer', size: 8
    #icon '<icon>mdi-phone</icon>773.213.0780 <icon>mdi-web</icon>chrishildebrand.net <icon>mdi-email-open</icon>chris@chrishildebrand.net', align: :center, inline_format: true
    icon(bio[:extra_info].join(space), inline_format: true, align: :center)
  }
end

def write_skills(skills)
  sub_section_gap = 5

  text("Skills")
  skills.each_with_index do |(section, values), index|
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
  sub_section_gap = 21
  text(experience[:label])

  bounding_box([CONTENT_X, bounds.top], width: CONTENT_WIDTH) do
    title_opts = {style: :bold}
    date_opts = {size: 10, style: :italic}

    experience[:positions].each do |position|
      text(position[:title], title_opts)
      move_down 2
      text(position[:duration], date_opts)
      move_down 4
      position[:points].each { |point|
        text(point, size: 12)
        move_down 2
      }
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
    write_experience(information[:experience][:page_one])
  end

  start_new_page

  bounding_box([0, cursor], width: WIDTH) do
    write_experience(information[:experience][:page_two])
  end

  move_down SECTION_GAP
  bounding_box([0, cursor], width: WIDTH) do
    write_education(information[:education])
  end

end
