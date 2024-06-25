module AdoptablePetsHelper
  def age_ranges
    [["Less than 3 months", [3.months.ago.to_date, "none"].join("/")],
      ["Less than 6 months", [6.months.ago.to_date, "none"].join("/")],
      ["Less than 1 year", [1.year.ago.to_date, "none"].join("/")],
      ["Young Adult(1 to 3 years)", [3.years.ago.to_date, 1.year.ago.to_date].join("/")],
      ["Adult(3 to 7 years)", [7.years.ago.to_date, 3.years.ago.to_date].join("/")],
      ["Senior(7 years and older)", ["none", 7.years.ago.to_date].join("/")]]
  end
end
