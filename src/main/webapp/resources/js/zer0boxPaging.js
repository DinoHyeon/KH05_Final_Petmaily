
    $.fn.zer0boxPaging = function( opt ) {
        var option = $.extend({"default":"none"}, opt );//외부로 부터 받아올 옵션

        //li 태그의 스타일  
        var liCss = {
            "display":"inline",
            "border" : "1px solid gray",
            "padding" : "5px 10px",
            "margin" : "0 3px",
            "font-weight" : 600,
            "color":"dodgerblue",
            "cursor":"pointer"            
        };

        this.empty();//한번 지우고
        var start = 1;
        var end = 5;
        
        var content = "<ul style='list-style:none; margin:10px'>";
				
        if(option.currPage > option.viewRange){          	
			end = Math.ceil(option.currPage/option.viewRange)*option.viewRange;
			start = end-(option.viewRange-1);       
	        console.log("plugin",start+" ~ "+end);
			content +="<li page='"+(start-1)+"'>Prev</li>";
        }
		
        for(var i = start; i<=end;i++){
            if(i <= option.maxPage){
                if(option.currPage == i){
                    content +="<li style='background-color:lightgray'>"+i+"</li>";
                }else{
                    content +="<li page='"+i+"'>"+i+"</li>";
                }
    
            }
        }
		
        if(end < option.maxPage){
            content +="<li page='"+(end+1)+"'>Next</li>"
        }
    
        content += "</ul>"
        this.append(content);
        var li = this.find("li");
        li.on("click",option.clickAction);
        li.hover(function(){
            $(this).css("border-color","red");
        },function(){
            $(this).css("border-color","gray");
        });
        li.css(liCss);
    };