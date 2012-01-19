
function Dash () {
};

Dash.prototype.tbody = '';
Dash.prototype.rbody = '';
Dash.prototype.singleton = null;
Dash.prototype.STATUS_STR = new Array ('not started', 'started', 'submitted', 'in review', 'in revision', 'completed');

Dash.prototype.init = function (tbody_name) {

    console.log ('dash init (enter)');
    this.tbody = document.getElementById (tbody_name);
    this.rbody = document.getElementById ('review_list_area');
    doAjax ('GET', 'assignment/list', {} , Dash.prototype.loadList );
    doAjax ('GET', 'reviews/list', {} , Dash.prototype.loadReviews );
    appendMsg ('... fetching assignment list ...');
    Dash.prototype.singleton = this;
    console.log ('dash init (exit)');

}; // init

Dash.prototype.loadList = function (data) {

    var dash = Dash.prototype.singleton;

    console.log ('load list');
    if (data['results']) {
        for (var idx in data['results']) {
            var a = data['results'][idx]['assignment'][0];
            var tr = dash.tbody.insertRow (-1);

            // name
            var td = tr.insertCell (-1);
            td.innerHTML += a['name'];
            
            // info 
            td = tr.insertCell (-1);
            td.innerHTML += a['info'];

            // status 
            td = tr.insertCell (-1);
            td.innerHTML += data['results'][idx]['status'];
           // td.innerHTML += dash.STATUS_STR[data['results'][idx]['status']];

            // Action
            td = tr.insertCell (-1);
            if (data['results'][idx]['essay']) {
                td.innerHTML += '<a href="' + URI_BASE + 'edit/' + data['results'][idx]['essay'] + '"> Edit </a>';
            } 
            else {
                td.innerHTML += '<a href="' + URI_BASE + 'essay/create/' + a['assignment'] + '"> Start </a>';
            } // if
            
            // due date 
            td = tr.insertCell (-1);
            td.innerHTML += formatDate (a['due_date']);
            
        } // for
        //var d = new Date();
        writeMsg ('number of assignments found: ' + data['results'].length);
        //writeMsg ('<b>' + formatDate (d.getTime()/1000) + '</b>: number of assignments found: ' + data['results'].length);
    } 
    else {
        writeMsg ('dashboard load list failed');
    }

}; // loadList

Dash.prototype.loadReviews = function (data) {

    var dash = Dash.prototype.singleton;

    console.log ('load reviews');
    if (data['results']) {
        for (var idx in data['results']) {
            var essay = data['results'][idx]['essay'];
            var when = data['results'][idx]['create_date'];
            var tr = dash.rbody.insertRow (-1);

            // name
            var td = tr.insertCell (-1);
            td.innerHTML += '<a href="' + URI_BASE + 'view/review/' + essay + '"> Review ' + idx + ' </a>';
            
            // due date 
            td = tr.insertCell (-1);
            td.innerHTML += formatDate (when);
            
        } // for
        //var d = new Date();
        writeMsg ('number of reviews found: ' + data['results'].length);
        //writeMsg ('<b>' + formatDate (d.getTime()/1000) + '</b>: number of assignments found: ' + data['results'].length);
    } 
    else {
        writeMsg ('dashboard load list failed');
    }

}; // loadReviews
