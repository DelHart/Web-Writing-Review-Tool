
function Review () {
};

Review.prototype = new BindableObject ();
Review.prototype.control_widget_container = '';
Review.prototype.editing_widget_container = '';
Review.prototype.rubric_widget_container = '';
Review.prototype.essay = null;
Review.prototype.criteria = null;

Review.prototype.init = function (ca, ea, eid) {
    
    registry.setShortCut ('review', this);
    this.control_widget_container = ca;
    this.editing_widget_container = ea;
    
    this.bind ('save', this.save);
    this.bind ('saveClose', this.saveClose);
    this.bind ('saveCallback', this.saveCallback);
    
    this.essay = new Essay ();
    this.essay.init (eid);
   
    this.createReviewView (ca, ea);

	$.ajax({
  		type: 'GET',
  		url: URI_BASE + 'essay/' + eid,
  		data: {},
  		success: Review.prototype.loadEssay,
  		dataType: 'json'
		});



}; //

Review.prototype.loadReview = function (data) {
    var rev = registry.getShortCut ('review');

    // load results into the review form
    var info = data.review[0];
    
    for (var idx in rev.criteria) {
	var criteria = rev.criteria[idx];
        var key = criteria.name;
        if (criteria.name == 'overall quality') {
            key = 'overall';
        }
        var field = document.getElementById ('review:' + criteria.rubric);
        field.selectedIndex = info[key];
        
    } // for
    document.getElementById ('review:comment').value = info.comment;

}; // loadReview

Review.prototype.createReviewView = function (ca, ea) {
    
    this.control_widget_container = document.getElementById(ca);
    

    var parent = document.getElementById (ea);
    parent.innerHTML = "<table style='max-width: 600px;'><tr><td><h2 id='title_field'>Title</h2></td></tr>" +
        "<tr><td><b>Approach</b></td></tr><tr><td><div id='approach_field'></div></td></tr>" +
        "</table><table cellspacing='20px'  style='max-width: 600px;'><tr><th> Purpose </th><th>Text</th></tr><tbody id='edit_table'></tbody></table>" +
        "<h2>References</h2>"+
        "<table border='1'><tr><th>Name</th><th>Utility</th><th>URL</th></tr><tbody id='references_table'> </tbody></table>";

}; // createEditView

Review.prototype.loadEssay = function (data) {
    var rev = registry.getShortCut ('review');
    
    rev.essay.loadEssay(data);
    $('#status_field').html(rev.essay.status_var);
    $('#title_field').html(rev.essay.title);
    $('#approach_field').html(rev.essay.approach);

    rev.drawParagraphs();
    rev.drawReferences();
    writeMsg ('essay loaded');

}; // loadEssay

Review.prototype.drawParagraphs = function () {
    var table = document.getElementById ('edit_table');
    while (table.hasChildNodes()) {
	table.removeChild(table.firstChild);
    } // while

    for (i=0;i<this.essay.paragraph_list.length;i++) {
	var tr = table.insertRow (i);
	this.drawParagraph (i, tr);
    } // for

}; // drawParagraphs

Review.prototype.drawParagraph = function (index, row) {
    var par = this.essay.paragraph_list[index];
    var text = par.words.join (' ');

    var td = row.insertCell (-1);
    td.innerHTML = par.idea;
    td = row.insertCell (-1);
    td.innerHTML = text;

    par.position = index;

}; // drawParagraph


Review.prototype.drawReferences = function () {
    var table = document.getElementById ('references_table');
    while (table.hasChildNodes()) {
	table.removeChild(table.firstChild);
    } // while

    for (i=0;i<this.essay.reference_list.length;i++) {
	var tr = table.insertRow (-1);
	this.drawReference (i, tr);
    } // for

}; // drawReferences


Review.prototype.drawReference = function (index, tr) {
    
    var ref = this.essay.reference_list[index];

    var td = tr.insertCell (-1);
    td.innerHTML = ref.name;
    td = tr.insertCell (-1);
    td.innerHTML = ref.utility;
    td = tr.insertCell (-1);
    td.innerHTML = ref.url;

}; // drawReference

Review.prototype.save = function (callback) {
    
    var data = {};
    
    // iterate through criteria to get information out
    for (var idx in this.criteria) {
        var crit = this.criteria[idx];
        var name = crit.name;
	data[name] = document.getElementById('review:'+crit.rubric).value;
    }
    data.comment = document.getElementById('review:comment').value;

    $.ajax({
      type: 'POST',
      url: URI_BASE + 'review/' + this.essay.essay_id,
      data: {'json' : $.toJSON ( data ) },
      success: function (data) { callObjMethod ('review', callback, data ) }, 
      dataType: 'json'
    });

}; // save


// wait until we get a response before we go to a different page
Review.prototype.saveClose = function (data) {

    window.location.href = URI_BASE + 'dash';

}; // saveClose

Review.prototype.saveCallback = function (data) {

    var d = new Date();
    var str = formatDate (d.getTime()/1000);
    document.getElementById ('save_status').innerHTML = "last save: " + str;
    this.save_disabled = false;

    // TODO: start autosave timer

}; // saveCallback


Review.prototype.showRubric = function (tab) {
    
    this.rubric_widget_container = document.getElementById(tab);
    
    $.ajax({
	type: 'GET',
  	url: URI_BASE + 'rubric/1',
  	data: {},
  	success: Review.prototype.loadRubric,
  	dataType: 'json'
    });


}; //

Review.prototype.loadRubric = function (data) {
    var rev = registry.getShortCut ('review');
    
    rev.criteria = data['results'];

    $.ajax({
  	type: 'GET',
  	url: URI_BASE + 'review/' + rev.essay.essay_id,
  	data: {},
  	success: Review.prototype.loadReview,
  	dataType: 'json'
    });
    
    
    var str = "<table><tr>";
    var row2 = "<tr>";
    for (var idx in rev.criteria) {
	var criteria = rev.criteria[idx];
	str += '<th>' + criteria.name + '</th>';
	row2 += '<td><select id="review:' + criteria.rubric + '">';
	var rv = criteria.rubric_values;
	for (var oidx in rv) {
	    row2 += "<option value='" + oidx + "'>" + rv[oidx].name + "</option>";
	}
	row2 += "</select></td>";
    } // for
    str += "</tr>";
    row2 += '</tr></table>';

    var save_close_fn = 'callObjMethod ("review", "save", "saveClose")';
    var save_fn = 'callObjMethod ("review", "save", "saveCallback")';
    rev.control_widget_container.innerHTML = str + row2 + "<h3>Comments</h3> <textarea id='review:comment' rows='10' cols='50'></textarea> <br/> <input type='button' value='save' onclick='" + save_fn + "'/> <input type='button' value='save and close' onclick='" + save_close_fn + "' />";
    
    
    str = "<div id='save_status'></div><table border='1'><tr><th>Name</th><th>Description</th><th colspan='0'>Values</th></tr><tr>";
    for (var idx in rev.criteria) {
	var criteria = rev.criteria[idx];
	str += '<th>' + criteria.name + '</th><td>' + criteria.info + '</td>';
	var rv = criteria.rubric_values;
	for (var oidx in rv) {
	    str += "<td><b>" + rv[oidx].name + "</b><br/>" + rv[oidx].information + '</td>';
	}
	str += '</tr>';
    } // for
    rev.rubric_widget_container.innerHTML = str + '</table>';
    


    writeMsg ('rubric loaded, loading review data');

}; // loadRubric
