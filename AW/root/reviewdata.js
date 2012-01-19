
function EssayReview () {
};

EssayReview.prototype = new BindableObject ();
EssayReview.prototype.review_id = 0;
EssayReview.prototype.essay_id = 0;
EssayReview.prototype.essay_rev = 0;
EssayReview.prototype.focus = 0;
EssayReview.prototype.evidence = 0;
EssayReview.prototype.presentation = 0;
EssayReview.prototype.ideas = 0;
EssayReview.prototype.size = 0;
EssayReview.prototype.id_generator = 0;
EssayReview.prototype.paragraph_map = {};
EssayReview.prototype.error_list = new Array();

EssayReview.prototype.init = function (eid) {
    
    registry.setShortCut ('essay_review', this);
    this.essay_id = eid;
   
    this.bind ('loadReview',    this.loadReview);

}; // init


EssayReview.prototype.loadReview = function (data) {

    if (data['review']) {
        this.review_id = data['review']['title'];
        this.status_var = data['review']['status'];
        this.approach = data['review']['approach'];
        this.id_generator = data['review']['counter'];

        for (var idx in data['essay']['pars']) {
            var par = data['essay']['pars'][idx];
            var p = new Paragraph ();
            p.load (par);
            this.paragraph_list[idx] = p;
        } // for

	for (var idx in data['essay']['refs']) {
            var ref = data['essay']['refs'][idx];
            var r = new Reference ();
            r.load (ref);
            this.reference_list[idx] = r;
        } // for

    }
	

}; // loadEssay

Essay.prototype.addParagraph = function (loc) {
    var p = new Paragraph ();
    p.init (++this.id_generator);
    p.idea = " ";
    this.paragraph_list.splice (loc, 0, p);
    return p;
}; // addParagraph

Essay.prototype.moveParagraph = function (loc, delta) {
    var p = this.paragraph_list[loc];
    this.paragraph_list.splice (loc, 1);
    if (delta == 1) {
	this.paragraph_list.splice (loc+1, 0, p);
    } 
    else {
	if (loc == 0) {
	    this.paragraph_list.splice (loc, 0, p);
	}
	else {
	    this.paragraph_list.splice (loc - 1, 0, p);
	}

    } // if

}; // moveParagraph

Essay.prototype.addReference = function (name, utility, url) {
    var ref = new Reference ();
    ref.init (++this.id_generator);

    ref.name = name;
    ref.utility = utility;
    ref.url = url;
    this.reference_list[this.reference_list.length] = ref;
};

///Paragraph
   ///Presentation
   ///Focus
   ///Flow

///Errors
   ///Syntax - violation of rules of English
   ///Semantic - something that is incorrect
   ///Inconsistency - contradicts another part
   ///Ambiguous 
   ///Not relevant


function Paragraph () {
};

Paragraph.prototype = new BindableObject ();
Paragraph.prototype.idea = '';
Paragraph.prototype.par_id   = 0;
Paragraph.prototype.modified = false;        // whether it needs to be saved
Paragraph.prototype.words = null;
Paragraph.prototype.position = -1;
Paragraph.prototype.key_log = null;
Paragraph.prototype.time_log = null;

Paragraph.prototype.init = function (id_val) {
    this.par_id = id_val;
    registry.setShortCut ('p:'+id_val, this);
    this.bind ('log', this.logKey);
    this.words = new Array ();
    this.key_log = new Array ();
    this.time_log = new Array ();
} // init

Paragraph.prototype.logKey = function (e) {
      var ev = e || window.event;
      var d = new Date();
      var t = parseInt (d.getTime()/1000);
      this.time_log[this.time_log.length] = t;
      this.key_log[this.key_log.length] =  ev.which || ev.keyCode;
}; // logKey 


Paragraph.prototype.load = function (data) {

    this.par_id   = data['id'];
    registry.setShortCut ('p:'+this.par_id, this);
    this.idea = data['idea'];
    this.words = data['words'];
    this.position = data['position'];
    registry.setShortCut ('p:'+this.par_id, this);
    this.bind ('log', this.logKey);
    this.key_log = new Array ();
    this.time_log = new Array ();

}; // load



function Reference () {
};

Reference.prototype = new BindableObject ();
Reference.prototype.name = '';
Paragraph.prototype.utility = '';
Paragraph.prototype.url = '';
Reference.prototype.eref_id   = 0;

Reference.prototype.init = function (id_val) {
    this.eref_id = id_val;
    registry.setShortCut ('r:'+id_val, this);
} // init

Reference.prototype.load = function (data) {

    this.eref_id   = data['id'];
    registry.setShortCut ('r:'+this.eref_id, this);
    this.name = data['name'];
    this.url = data['url'];
    this.utility = data['utility'];

}; // load



