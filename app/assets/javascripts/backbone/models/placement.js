const Placement = Backbone.Model.extend({
  urlRoot: 'http://localhost:3000/placements/',

  constructor: function(attributes, options) {
    this.companies = new CompanyCollection();

    this.unplacedStudents = new Company({
      slots: 24,
      name: "Unplaced Students"
    }, {
      requireInterview: false
    });

    // Call the superclass (Backbone.Model) constructor
    Backbone.Model.apply(this, arguments);
  },

  // Incoming JSON looks like:
  // {
  //     "id": 545248419,
  //     "companies": [ {
  //         "id": 309418106,
  //         "name": "Stark Industries",
  //         "slots": 1
  //     }, ... ],
  //     "pairings": [ {
  //         "company_id": 309418106,
  //         "student_id": 225478506
  //     }, ... ],
  //     "students": [ {
  //         "id": 225478506,
  //         "name": "Ada Lovelace",
  //         "rankings": [ {
  //             "company_id": 739272092,
  //             "interview_result": 3,
  //             "student_ranking": 4
  //         }, ... ]
  //     }, ... ]
  // }
  parse: function(response, options) {
    // XXX DPR: what if fetch is called twice?
    console.debug("In Placement.parse(), response looks like:");
    console.debug(response);

    // Add all companies from the response
    this.companies.add(response.companies);

    // Build list of unplaced students
    // Initially add all students, we'll remove placed
    // students in the next step.
    this.unplacedStudents.students.add(response.students, {
      companies: this.companies,
      parse: true
    });

    // Move students who have already been placed out of
    // unplacedStudents and into their company
    response.pairings.forEach(function(pair) {
      if (!this.companies.get(pair.company_id)) {
        throw 'No such company ' + pair.company_id
      }
      if (!this.unplacedStudents.students.get(pair.student_id)) {
        throw 'Student ' + pair.student_id + ' does not exist or has already been placed'
      }
      const student = this.unplacedStudents.students.remove(pair.student_id);
      this.companies.get(pair.company_id).students.add(student);
    }, this);
  },

  // return a copy, ready for serialization
  toJSON: function() {
    console.log("In placement.toJSON()");
    json = {
      id: this.id,
      pairings: []
    }
    this.companies.forEach(function(company) {
      company.students.forEach(function(student) {
        json.pairings.push({
          company_id: company.id,
          student_id: student.id
        });
      }, this);
    }, this);
    console.log(json);
    return { placement: json };
  }
});
