
function Editor () {
};

Editor.prototype = new BindableObject ();
Editor.prototype.control_widget_container = '';
Editor.prototype.editing_widget_container = '';
Editor.prototype.essay = null;
Editor.prototype.need_save = 0;
Editor.prototype.save_disabled = false;
Editor.prototype.init = function (ca, ea, eid) {
    
    registry.setShortCut ('editor', this);
    this.control_widget_container = ca;
    this.editing_widget_container = ea;
    this.essay = new Essay();
    this.essay.init (eid);
   
    this.bind ('addParagraph', this.addParagraph);
    this.bind ('moveParagraph', this.moveParagraph);
    this.bind ('save', this.save);
    this.bind ('saveClose', this.saveClose);
    this.bind ('saveCallback', this.saveCallback);
    this.bind ('addReference', this.addReference);
    this.createEditView (ca, ea);

  //  doAjax ('GET', '/essay/' + eid, {} , Editor.prototype.loadEssay );
    $.ajax({
 	type: 'GET',
 	url: URI_BASE + 'essay/' + eid,
 	data: {},
 	success: Editor.prototype.loadEssay,
 	dataType: 'json'
    });


}; //

Editor.prototype.createEditView = function (ca, ea) {
    var parent = document.getElementById (ca);
    var save_fn = 'callObjMethod ("editor", "save", "saveCallback")';
    var save_close_fn = 'callObjMethod ("editor", "save", "saveClose")';
    var add_ref_fn = 'callObjMethod ("editor", "addReference")';
    var status_options = "";
    for (var i=0; i<=100; i+=10) {
        status_options  += "<option value='" + i + "'>"+i+"</option>";
    } // status_options
    parent.innerHTML = "<table><tr><td>Percent Done</td></tr>" +
                       "<tr><td><select id='status_select'>" + status_options + "</select></td></tr>" +
                       "<tr><td><input type='button' value='save and close' onclick='" + save_close_fn +"'/></td></tr>" +
                       "<tr><td><input type='button' value='save' onclick='" + save_fn +"'/></td></tr>" +
                       "<tr> <td> <div id='save_status'>saved</div></td></tr>" +
                       "</table>";

    parent = document.getElementById (ea);
    parent.innerHTML = "<table><tr><td><h2>Title</h2></td><td><input type='textfield' size='72' id='title_field'/></td></tr>" +
        "<tr><td><h2>Approach</h2></td><td><textarea cols='72' rows='10' id='approach_field'></textarea></td></tr>" +
        "<tr><td align='center' colspan='2'><h1>Essay</h1></td></tr></table><table id='edit_table'></table>" +
        "<h2>New Reference</h2>"+
        "<table><tr><th>Name</th><th>Utility</th><th>URL</th></tr>" +
        "<tr><td valign='top'><input type='textfield' id='nr_name'/></td>" +
        "<td><textarea id='nr_utility'></textarea></td>" +
        "<td valign='top'><input type='textfield' id='nr_url'/></td></tr>" +
        "<tr><td><input type='button' value='add reference' onclick='" + add_ref_fn + "'/></td></tr></table>"  +
        "<h2>References</h2>"+
        "<table border='1'><tr><th>Name</th><th>Utility</th><th>URL</th></tr><tbody id='references_table'> </tbody></table>";

}; // createEditView

Editor.prototype.loadEssay = function (data) {
    var ed = registry.getShortCut ('editor');
    
    ed.essay.loadEssay(data);

    ed.addButton(0);
    ed.drawParagraphs();
    ed.drawReferences();
    ed.title (ed.essay.title);
    ed.statusVar (ed.essay.status_var);
    ed.approach (ed.essay.approach);
    writeMsg ('essay loaded');

}; // loadEssay

Editor.prototype.addParagraph = function (loc) {
    this.normalizePars ();
    this.essay.addParagraph(loc);
    this.drawParagraphs();
    return;
}; // addParagraph

Editor.prototype.moveParagraph = function (loc, delta) {
    this.normalizePars ();
    this.essay.moveParagraph (loc, delta);
    this.drawParagraphs ();
}; // moveParagraph

Editor.prototype.normalizePars  = function () {
    for (var i in this.essay.paragraph_list) {
        this.normalizeWords (i);
    } // for
}; // normalizePars

Editor.prototype.addButton = function (loc) {
    var table = document.getElementById ('edit_table');
    var tr = table.insertRow (loc * 2);
    var td = tr.insertCell (-1);
    var add_fn = 'callObjMethod ("editor", "addParagraph", ';
    td.innerHTML = "<input type='button' value='Add Paragraph' onclick='"+add_fn+loc+")'/>";
}; // addButton

Editor.prototype.drawParagraphs = function () {
    var table = document.getElementById ('edit_table');
    while (table.hasChildNodes()) {
	table.removeChild(table.firstChild);
    } // while

    this.addButton(0);
    for (i=0;i<this.essay.paragraph_list.length;i++) {
	var tr = table.insertRow (i * 2 + 1);
	td = tr.insertCell (-1);
	this.drawParagraph (i, td);
	this.addButton (i+1);
    } // for

}; // drawParagraphs

Editor.prototype.drawParagraph = function (index, cell) {
    var par = this.essay.paragraph_list[index];
    var text = par.words.join (' ');

    var log_fn = 'callObjMethod ("p:' + par.par_id + '", "log", event)';
    var move_fn = 'callObjMethod ("editor", "moveParagraph", ';
    var move = "<table><tr><td><input type='button' value='up' onclick='" + move_fn + index +",-1)'/></td></tr><tr><td><input type='button' value='down' onclick='"+ move_fn +index +",1)'/></td></tr></table>";

    cell.innerHTML = "<table border='1'><tr><th rowspan='2'>" + move + "</th><th>Purpose</th><th>Text</th></tr>" +
    "<tr><td><textarea cols='30' id='" + par.par_id + ":idea'>"+ par.idea + "</textarea></td>" +
    "<td><textarea rows='10' cols='72' id='" + par.par_id + ":text' onkeydown='" + log_fn + "'>" + text + "</textarea></td></tr></table>";
    par.position = index;

}; // drawParagraph

Editor.prototype.saveCallback = function (data) {

    var d = new Date();
    var str = formatDate (d.getTime()/1000);
    document.getElementById ('save_status').innerHTML = "last save: " + str;
    this.save_disabled = false;

    // TODO: start autosave timer

}; // saveCallback

Editor.prototype.save = function (callback) {

    var title = this.title();
    var approach = this.approach();
    var status_var = this.statusVar();

    // only allow one save at a time
    if (this.save_disabled == true) {
	return;
    }
    this.save_disabled = true;

    var pars = new Array ();
    for (var i in this.essay.paragraph_list) {
        var p = this.essay.paragraph_list[i];
        this.normalizeWords (i);
        pars[pars.length] = { 'id' : p.par_id, 'idea' : p.idea, 'words' : p.words, 'position' : p.position, 'keys' : p.key_log, 'times' : p.time_log  };
        p.key_log = new Array();
        p.time_log = new Array();
    } // for

    var refs = new Array ();
    for (var i in this.essay.reference_list) {
        var r = this.essay.reference_list[i];
        refs[refs.length] = { 'id' : r.eref_id, 'name' : r.name, 'utility' : r.utility, 'url' : r.url  };
    } // for

    document.getElementById ('save_status').innerHTML = "saving...";
    $.ajax({
      type: 'POST',
      url: URI_BASE + 'essay/' + this.essay.essay_id,
      data: {'json' : $.toJSON ({ 'status' : status_var, 'title' : title, 'approach' : approach, 'counter' : this.essay.id_generator, 'pars' : pars, 'refs' : refs }) },
      success: function (data) { callObjMethod ('editor', callback, data ) }, 
      dataType: 'json'
    });

}; // save


Editor.prototype.saveClose = function (data) {

    window.location.href = URI_BASE + 'dash';

}; // saveClose

Editor.prototype.title = function (data) {
    if (data != null) {
        this.essay.title = data;
        document.getElementById ('title_field').setAttribute ('value', data);
    }
    else {
        this.essay.title = document.getElementById ('title_field').value;
    }
    return this.essay.title;
}; // title accessor

Editor.prototype.statusVar = function (data) {
    if (data != null) {
        this.essay.status_var = data;
        var i = parseInt (data);
        i = i / 10;
        var sel_obj = document.getElementById ('status_select');
        document.getElementById ('status_select').selectedIndex = i;
    }
    else {
        this.essay.status_var = document.getElementById ('status_select').value;
    }
    return this.essay.status_var;
}; // status accessor

Editor.prototype.approach = function (data) {
    if (data != null) {
        this.essay.approach = data;
        var ta = document.getElementById ('approach_field');
        while (ta.hasChildNodes()) {
            ta.removeChild(0);
        }
        ta.appendChild(document.createTextNode(data));
    }
    else {
        this.essay.approach = document.getElementById ('approach_field').value;
    }
    return this.essay.approach;
}; // title accessor

Editor.prototype.addReference = function (data) {

    // copy the reference data out of the fields, put it into the list and redraw
    var name = document.getElementById ('nr_name').value;
    var util = document.getElementById ('nr_utility').value;
    var url  = document.getElementById ('nr_url').value;
    this.essay.addReference (name, util, url);

    document.getElementById ('nr_name').value = '';
    document.getElementById ('nr_utility').value = '';
    document.getElementById ('nr_url').value = '';

    this.drawReferences();

}; // addReference

Editor.prototype.drawReferences = function () {
    var table = document.getElementById ('references_table');
    while (table.hasChildNodes()) {
	table.removeChild(table.firstChild);
    } // while

    for (i=0;i<this.essay.reference_list.length;i++) {
	var tr = table.insertRow (-1);
	this.drawReference (i, tr);
    } // for

}; // drawReferences

Editor.prototype.drawReference = function (index, tr) {
    
    var ref = this.essay.reference_list[index];

    var td = tr.insertCell (-1);
    td.innerHTML = "<input type='text' id='r:" + ref.eref_id + ":name' value='" + ref.name + "' size='12'/>";
    td = tr.insertCell (-1);
    td.innerHTML = "<input type='text' id='r:" + ref.eref_id + ":utility' value='" + ref.utility + "' size='30'/>";
    td = tr.insertCell (-1);
    td.innerHTML = "<input type='text' id='r:" + ref.eref_id + ":url' value='" + ref.url + "' size='30'/>";

}; // drawReference


Editor.prototype.normalizeWords = function (index) {
    var par = this.essay.paragraph_list[index];
    var text = document.getElementById (par.par_id + ':text');
    if (text != null) {
        var raw = document.getElementById (par.par_id + ':text').value;
	//var re = new RegExp ("/[^A-Za-z0-9 ]/g");
//	raw.replace (/[^A-Za-z0-9\ ]/g, '');
        par.words = raw.split (/\s+/);
        par.normalized = true;
    } 
    else {
	console.log ('normalize words failed for paragraph ' + index + ' could not find text element');
    } // if
    
    par.idea = document.getElementById (par.par_id + ':idea').value;
}; // normalizeWords

