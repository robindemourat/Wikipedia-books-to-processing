//scrapped from : http://fr.wikisource.org/wiki/Les_Fleurs_du_mal/1861

artoo.scrape('.tableItem', {

	numero : function($){
		var num = $(this).find("span:first-child").text().split('.')[0];
		if(num.trim() === "Au lecteur Au lecteur 11")
			num = "Au lecteur";
		return num;
	},

	link : function($){
		return "http://fr.wikisource.org/" + $(this).find("a").attr('href');
	},
	title : function($){
		return $(this).find("a").text();
	},
});