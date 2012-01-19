
function IDash () {
};

IDash.prototype = new BindableObject();
IDash.prototype.tbody = '';
IDash.prototype.STATUS_STR = new Array ('not started', 'started', 'submitted', 'in review', 'in revision', 'completed');

IDash.prototype.init = function (tbody_name) {

    registry.setShortCut ('idash', this);
    this.bind ('fetchAssignment', this.fetchAssignment);

    console.log ('dash init (enter)');
    this.tbody = document.getElementById (tbody_name);
    doAjax ('GET', '/instructor/list', {} , IDash.prototype.loadList );
    appendMsg ('... fetching instructor assignment list ...');
    console.log ('dash init (exit)');

}; // init

IDash.prototype.loadList = function (data) {


    var dash = registry.getShortCut ('idash');

    console.log ('load list');
    if (data['results']) {
        for (var idx in data['results']) {
            var a = data['results'][idx];
            var tr = dash.tbody.insertRow (-1);

            // assignment
            var td = tr.insertCell (-1);
            td.innerHTML += "<input type='button' onclick='callObjMethod (\"idash\", \"fetchAssignment\", " + a['assignment'] + ")' value='" + a['assignment'] + "'/>";

            // name
            var td = tr.insertCell (-1);
            td.innerHTML += a['name'];
            
            // due date 
            td = tr.insertCell (-1);
            td.innerHTML += formatDate (a['due_date']);

            // info
            var td = tr.insertCell (-1);
            td.innerHTML += a['info'];

            // url
            var td = tr.insertCell (-1);
            td.innerHTML += a['url'];
            
            
        } // for
        //var d = new Date();
        writeMsg ('number of assignments found: ' + data['results'].length);
        //writeMsg ('<b>' + formatDate (d.getTime()/1000) + '</b>: number of assignments found: ' + data['results'].length);
    } 
    else {
        writeMsg ('dashboard load list failed');
    }

}; // loadList

IDash.prototype.fetchAssignment = function (aid) {

    doAjax ('GET', '/instructor/assignment/'+aid, {} , IDash.prototype.loadAssignment );
    writeMsg ('fetching data for assignment ' + aid);

}; // fetchAssignment

IDash.prototype.loadAssignment = function (data) {


    var dash = registry.getShortCut ('idash');

    var tbody = document.getElementById ('essay_list_area');
    while (tbody.hasChildNodes()) {
        tbody.removeChild(tbody.firstChild);
    } // while

    console.log ('load assignment');
    if (data['results']) {
        for (var idx in data['results']) {
            var a = data['results'][idx];
            var tr = tbody.insertRow (-1);

            // Person
            var td = tr.insertCell (-1);
            //td.innerHTML += "<input type='button' value='" + a['assignment'] + "'/>";
	    td.innerHTML += a['person'];

            // status
            var td = tr.insertCell (-1);
            td.innerHTML += a['status'];
            
            // essay
            td = tr.insertCell (-1);
            td.innerHTML += "<a href = '" + URI_BASE + "review/" + a['essay'] + "'> " + a['essay'] + "</a>";
            
            
        } // for
        //var d = new Date();
        writeMsg ('number of assignments found: ' + data['results'].length);
        //writeMsg ('<b>' + formatDate (d.getTime()/1000) + '</b>: number of assignments found: ' + data['results'].length);
    } 
    else {
        writeMsg ('dashboard load list failed');
    }

}; // loadAssignment

