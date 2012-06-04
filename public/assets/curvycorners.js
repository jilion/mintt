function browserdetect(){var a=navigator.userAgent.toLowerCase();this.isIE=a.indexOf("msie")>-1,this.ieVer=this.isIE?/msie\s(\d\.\d)/.exec(a)[1]:0,this.isMoz=a.indexOf("firefox")!=-1,this.isSafari=a.indexOf("safari")!=-1,this.quirksMode=this.isIE&&(!document.compatMode||document.compatMode.indexOf("BackCompat")>-1),this.isOp="opera"in window,this.isWebKit=a.indexOf("webkit")!=-1,this.isIE?this.get_style=function(a,b){if(b in a.currentStyle){var c=/^([\d.]+)(\w*)/.exec(a.currentStyle[b]);if(!c)return a.currentStyle[b];if(c[1]==0)return"0";if(c[2]&&c[2]!=="px"){var d=a.style.left,e=a.runtimeStyle.left;a.runtimeStyle.left=a.currentStyle.left,a.style.left=c[1]+c[2],c[0]=a.style.pixelLeft,a.style.left=d,a.runtimeStyle.left=e}return c[0]}return""}:this.get_style=function(a,b){return b=b.replace(/([a-z])([A-Z])/g,"$1-$2").toLowerCase(),document.defaultView.getComputedStyle(a,"").getPropertyValue(b)}}function curvyCnrSpec(a){this.selectorText=a,this.tlR=this.trR=this.blR=this.brR=0,this.tlu=this.tru=this.blu=this.bru="",this.antiAlias=!0}function operasheet(a){var b=document.styleSheets.item(a).ownerNode.text;b=b.replace(/\/\*(\n|\r|.)*?\*\//g,"");var c=new RegExp("^s*([\\w.#][-\\w.#, ]+)[\\n\\s]*\\{([^}]+border-((top|bottom)-(left|right)-)?radius[^}]*)\\}","mg"),d;this.rules=[];while((d=c.exec(b))!==null){var e=new RegExp("(..)border-((top|bottom)-(left|right)-)?radius:\\s*([\\d.]+)(in|em|px|ex|pt)","g"),f,g=new curvyCnrSpec(d[1]);while((f=e.exec(d[2]))!==null)f[1]!=="z-"&&g.setcorner(f[3],f[4],f[5],f[6]);this.rules.push(g)}}function curvyCorners(){var a,b,c,d,e;if(typeof arguments[0]!="object")throw curvyCorners.newError("First parameter of curvyCorners() must be an object.");if(arguments[0]instanceof curvyCnrSpec)d=arguments[0],!d.selectorText&&typeof arguments[1]=="string"&&(d.selectorText=arguments[1]);else{if(typeof arguments[1]!="object"&&typeof arguments[1]!="string")throw curvyCorners.newError("Second parameter of curvyCorners() must be an object or a class name.");b=arguments[1],typeof b!="string"&&(b=""),b!==""&&b.charAt(0)!=="."&&"autoPad"in arguments[0]&&(b="."+b),d=new curvyCnrSpec(b),d.setfrom(arguments[0])}if(d.selectorText){e=0;var f=d.selectorText.replace(/\s+$/,"").split(/,\s*/);c=new Array;function g(a){var b=a.split("#");return(b.length===2?"#":"")+b.pop()}for(a=0;a<f.length;++a){var h=g(f[a]),i=h.split(" ");switch(h.charAt(0)){case"#":b=i.length===1?h:i[0],b=document.getElementById(b.substr(1)),b===null?curvyCorners.alert("No object with ID "+h+" exists yet.\nCall curvyCorners(settings, obj) when it is created."):i.length===1?c.push(b):c=c.concat(curvyCorners.getElementsByClass(i[1],b));break;default:if(i.length===1)c=c.concat(curvyCorners.getElementsByClass(h));else{var j=curvyCorners.getElementsByClass(i[0]);for(b=0;b<j.length;++b)c=c.concat(curvyCorners.getElementsByClass(i[1],j))}}}}else e=1,c=arguments;for(a=e,b=c.length;a<b;++a)if(c[a]&&(!("IEborderRadius"in c[a].style)||c[a].style.IEborderRadius!="set")){c[a].className&&c[a].className.indexOf("curvyRedraw")!==-1&&(typeof curvyCorners.redrawList=="undefined"&&(curvyCorners.redrawList=new Array),curvyCorners.redrawList.push({node:c[a],spec:d,copy:c[a].cloneNode(!1)})),c[a].style.IEborderRadius="set";var k=new curvyObject(d,c[a]);k.applyCorners()}}function curvyObject(){var a;this.box=arguments[1],this.settings=arguments[0],this.topContainer=this.bottomContainer=this.shell=a=null;var b=this.box.clientWidth;!b&&curvyBrowser.isIE&&(this.box.style.zoom=1,b=this.box.clientWidth);if(!b){if(!this.box.parentNode)throw this.newError("box has no parent!");for(a=this.box;;a=a.parentNode){if(!a||a.tagName==="BODY"){this.applyCorners=function(){},curvyCorners.alert(this.errmsg("zero-width box with no accountable parent","warning"));return}if(a.style.display==="none")break}a.style.display="block",b=this.box.clientWidth}arguments[0]instanceof curvyCnrSpec?this.spec=arguments[0].cloneOn(this.box):(this.spec=new curvyCnrSpec(""),this.spec.setfrom(this.settings));var c=curvyBrowser.get_style(this.box,"borderTopWidth"),d=curvyBrowser.get_style(this.box,"borderBottomWidth"),e=curvyBrowser.get_style(this.box,"borderLeftWidth"),f=curvyBrowser.get_style(this.box,"borderRightWidth"),g=curvyBrowser.get_style(this.box,"borderTopColor"),h=curvyBrowser.get_style(this.box,"borderBottomColor"),i=curvyBrowser.get_style(this.box,"borderLeftColor"),j=curvyBrowser.get_style(this.box,"backgroundColor"),k=curvyBrowser.get_style(this.box,"backgroundImage"),l=curvyBrowser.get_style(this.box,"backgroundRepeat");if(this.box.currentStyle&&this.box.currentStyle.backgroundPositionX)var m=curvyBrowser.get_style(this.box,"backgroundPositionX"),n=curvyBrowser.get_style(this.box,"backgroundPositionY");else{var m=curvyBrowser.get_style(this.box,"backgroundPosition");m=m.split(" ");var n=m[1];m=m[0]}var o=curvyBrowser.get_style(this.box,"position"),p=curvyBrowser.get_style(this.box,"paddingTop"),q=curvyBrowser.get_style(this.box,"paddingBottom"),r=curvyBrowser.get_style(this.box,"paddingLeft"),s=curvyBrowser.get_style(this.box,"paddingRight"),t=curvyBrowser.get_style(this.box,"border");filter=curvyBrowser.ieVer>7?curvyBrowser.get_style(this.box,"filter"):null;var u=this.spec.get("tR"),v=this.spec.get("bR"),w=function(a){if(typeof a=="number")return a;if(typeof a!="string")throw new Error("unexpected styleToNPx type "+typeof a);var b=/^[-\d.]([a-z]+)$/.exec(a);if(b&&b[1]!="px")throw new Error("Unexpected unit "+b[1]);return isNaN(a=parseInt(a))&&(a=0),a},x=function(a){return a<=0?"0":a+"px"};try{this.borderWidth=w(c),this.borderWidthB=w(d),this.borderWidthL=w(e),this.borderWidthR=w(f),this.boxColour=curvyObject.format_colour(j),this.topPadding=w(p),this.bottomPadding=w(q),this.leftPadding=w(r),this.rightPadding=w(s),this.boxWidth=b,this.boxHeight=this.box.clientHeight,this.borderColour=curvyObject.format_colour(g),this.borderColourB=curvyObject.format_colour(h),this.borderColourL=curvyObject.format_colour(i),this.borderString=this.borderWidth+"px solid "+this.borderColour,this.borderStringB=this.borderWidthB+"px solid "+this.borderColourB,this.backgroundImage=k!="none"?k:"",this.backgroundRepeat=l}catch(y){throw this.newError("getMessage"in y?y.getMessage():y.message)}var A=this.boxHeight,B=b;if(curvyBrowser.isOp){m=w(m),n=w(n);if(m){var C=B+this.borderWidthL+this.borderWidthR;m>C&&(m=C),m=C/m*100+"%"}if(n){var C=A+this.borderWidth+this.borderWidthB;n>C&&(n=C),n=C/n*100+"%"}}curvyBrowser.quirksMode||(this.boxWidth-=this.leftPadding+this.rightPadding,this.boxHeight-=this.topPadding+this.bottomPadding),this.contentContainer=document.createElement("div"),filter&&(this.contentContainer.style.filter=filter);while(this.box.firstChild)this.contentContainer.appendChild(this.box.removeChild(this.box.firstChild));o!="absolute"&&(this.box.style.position="relative"),this.box.style.padding="0",this.box.style.border=this.box.style.backgroundImage="none",this.box.style.backgroundColor="transparent",this.box.style.width=B+this.borderWidthL+this.borderWidthR+"px",this.box.style.height=A+this.borderWidth+this.borderWidthB+"px";var D=document.createElement("div");D.style.position="absolute",filter&&(D.style.filter=filter),curvyBrowser.quirksMode?D.style.width=B+this.borderWidthL+this.borderWidthR+"px":D.style.width=B+"px",D.style.height=x(A+this.borderWidth+this.borderWidthB-u-v),D.style.padding="0",D.style.top=u+"px",D.style.left="0",this.borderWidthL&&(D.style.borderLeft=this.borderWidthL+"px solid "+this.borderColourL),this.borderWidth&&!u&&(D.style.borderTop=this.borderWidth+"px solid "+this.borderColour),this.borderWidthR&&(D.style.borderRight=this.borderWidthR+"px solid "+this.borderColourL),this.borderWidthB&&!v&&(D.style.borderBottom=this.borderWidthB+"px solid "+this.borderColourB),D.style.backgroundColor=j,D.style.backgroundImage=this.backgroundImage,D.style.backgroundRepeat=this.backgroundRepeat,this.shell=this.box.appendChild(D),b=curvyBrowser.get_style(this.shell,"width");if(b===""||b==="auto"||b.indexOf("%")!==-1)throw this.newError("Shell width is "+b);this.boxWidth=b!=""&&b!="auto"&&b.indexOf("%")==-1?parseInt(b):this.shell.clientWidth,this.applyCorners=function(){if(this.backgroundObject){var b=function(a,b,c){if(a===0)return 0;var d;return a==="right"||a==="bottom"?c-b:a==="center"?(c-b)/2:a.indexOf("%")>0?(c-b)*100/parseInt(a):w(a)};this.backgroundPosX=b(m,this.backgroundObject.width,B),this.backgroundPosY=b(n,this.backgroundObject.height,A)}else this.backgroundImage&&(this.backgroundPosX=w(m),this.backgroundPosY=w(n));u&&(c=document.createElement("div"),c.style.width=this.boxWidth+"px",c.style.fontSize="1px",c.style.overflow="hidden",c.style.position="absolute",c.style.paddingLeft=this.borderWidth+"px",c.style.paddingRight=this.borderWidth+"px",c.style.height=u+"px",c.style.top=-u+"px",c.style.left=-this.borderWidthL+"px",this.topContainer=this.shell.appendChild(c));if(v){var c=document.createElement("div");c.style.width=this.boxWidth+"px",c.style.fontSize="1px",c.style.overflow="hidden",c.style.position="absolute",c.style.paddingLeft=this.borderWidthB+"px",c.style.paddingRight=this.borderWidthB+"px",c.style.height=v+"px",c.style.bottom=-v+"px",c.style.left=-this.borderWidthL+"px",this.bottomContainer=this.shell.appendChild(c)}var d=this.spec.cornerNames();for(var e in d)if(!isNaN(e)){var f=d[e],g=this.spec[f+"R"],h,i,j,k;f=="tr"||f=="tl"?(h=this.borderWidth,i=this.borderColour,k=this.borderWidth):(h=this.borderWidthB,i=this.borderColourB,k=this.borderWidthB),j=g-k;var l=document.createElement("div");l.style.height=this.spec.get(f+"Ru"),l.style.width=this.spec.get(f+"Ru"),l.style.position="absolute",l.style.fontSize="1px",l.style.overflow="hidden";var o,p,q,r=filter?parseInt(/alpha\(opacity.(\d+)\)/.exec(filter)[1]):100;for(o=0;o<g;++o){var s=o+1>=j?-1:Math.floor(Math.sqrt(Math.pow(j,2)-Math.pow(o+1,2)))-1;if(j!=g)var t=o>=j?-1:Math.ceil(Math.sqrt(Math.pow(j,2)-Math.pow(o,2))),x=o+1>=g?-1:Math.floor(Math.sqrt(Math.pow(g,2)-Math.pow(o+1,2)))-1;var y=o>=g?-1:Math.ceil(Math.sqrt(Math.pow(g,2)-Math.pow(o,2)));s>-1&&this.drawPixel(o,0,this.boxColour,r,s+1,l,!0,g);if(j!=g)if(this.spec.antiAlias){for(p=s+1;p<t;++p)if(this.backgroundImage!=""){var C=curvyObject.pixelFraction(o,p,j)*100;this.drawPixel(o,p,i,r,1,l,C>=30,g)}else if(this.boxColour!=="transparent"){var D=curvyObject.BlendColour(this.boxColour,i,curvyObject.pixelFraction(o,p,j));this.drawPixel(o,p,D,r,1,l,!1,g)}else this.drawPixel(o,p,i,r>>1,1,l,!1,g);x>=t&&(t==-1&&(t=0),this.drawPixel(o,t,i,r,x-t+1,l,!1,0)),q=i,p=x}else x>s&&this.drawPixel(o,s+1,i,r,x-s,l,!1,0);else q=this.boxColour,p=s;if(this.spec.antiAlias)while(++p<y)this.drawPixel(o,p,q,curvyObject.pixelFraction(o,p,g)*r,1,l,k<=0,g)}for(var E=0,G=l.childNodes.length;E<G;++E){var I=l.childNodes[E],J=parseInt(I.style.top),K=parseInt(I.style.left),L=parseInt(I.style.height);if(f=="tl"||f=="bl")I.style.left=g-K-1+"px";if(f=="tr"||f=="tl")I.style.top=g-L-J+"px";I.style.backgroundRepeat=this.backgroundRepeat;if(this.backgroundImage)switch(f){case"tr":I.style.backgroundPosition=this.backgroundPosX-this.borderWidthL+g-B-K+"px "+(this.backgroundPosY+L+J+this.borderWidth-g)+"px";break;case"tl":I.style.backgroundPosition=this.backgroundPosX-g+K+this.borderWidthL+"px "+(this.backgroundPosY-g+L+J+this.borderWidth)+"px";break;case"bl":I.style.backgroundPosition=this.backgroundPosX-g+K+1+this.borderWidthL+"px "+(this.backgroundPosY-A-this.borderWidth+(curvyBrowser.quirksMode?J:-J)+g)+"px";break;case"br":curvyBrowser.quirksMode?I.style.backgroundPosition=this.backgroundPosX+this.borderWidthL-B+g-K+"px "+(this.backgroundPosY-A-this.borderWidth+J+g)+"px":I.style.backgroundPosition=this.backgroundPosX-this.borderWidthL-B+g-K+"px "+(this.backgroundPosY-A-this.borderWidth+g-J)+"px"}}switch(f){case"tl":l.style.top=l.style.left="0",this.topContainer.appendChild(l);break;case"tr":l.style.top=l.style.right="0",this.topContainer.appendChild(l);break;case"bl":l.style.bottom=l.style.left="0",this.bottomContainer.appendChild(l);break;case"br":l.style.bottom=l.style.right="0",this.bottomContainer.appendChild(l)}}var N={t:this.spec.radiusdiff("t"),b:this.spec.radiusdiff("b")};for(z in N){if(typeof z=="function")continue;if(!this.spec.get(z+"R"))continue;if(N[z]){this.backgroundImage&&this.spec.radiusSum(z)!==N[z]&&curvyCorners.alert(this.errmsg("Not supported: unequal non-zero top/bottom radii with background image"));var O=this.spec[z+"lR"]<this.spec[z+"rR"]?z+"l":z+"r",Q=document.createElement("div");Q.style.height=N[z]+"px",Q.style.width=this.spec.get(O+"Ru"),Q.style.position="absolute",Q.style.fontSize="1px",Q.style.overflow="hidden",Q.style.backgroundColor=this.boxColour;switch(O){case"tl":Q.style.bottom=Q.style.left="0",Q.style.borderLeft=this.borderString,this.topContainer.appendChild(Q);break;case"tr":Q.style.bottom=Q.style.right="0",Q.style.borderRight=this.borderString,this.topContainer.appendChild(Q);break;case"bl":Q.style.top=Q.style.left="0",Q.style.borderLeft=this.borderStringB,this.bottomContainer.appendChild(Q);break;case"br":Q.style.top=Q.style.right="0",Q.style.borderRight=this.borderStringB,this.bottomContainer.appendChild(Q)}}var S=document.createElement("div");filter&&(S.style.filter=filter),S.style.position="relative",S.style.fontSize="1px",S.style.overflow="hidden",S.style.width=this.fillerWidth(z),S.style.backgroundColor=this.boxColour,S.style.backgroundImage=this.backgroundImage,S.style.backgroundRepeat=this.backgroundRepeat;switch(z){case"t":if(this.topContainer){curvyBrowser.quirksMode?S.style.height=100+u+"px":S.style.height=100+u-this.borderWidth+"px",S.style.marginLeft=this.spec.tlR?this.spec.tlR-this.borderWidthL+"px":"0",S.style.borderTop=this.borderString;if(this.backgroundImage){var T=this.spec.tlR?this.backgroundPosX-(u-this.borderWidthL)+"px ":"0 ";S.style.backgroundPosition=T+this.backgroundPosY+"px",this.shell.style.backgroundPosition=this.backgroundPosX+"px "+(this.backgroundPosY-u+this.borderWidthL)+"px"}this.topContainer.appendChild(S)}break;case"b":if(this.bottomContainer){curvyBrowser.quirksMode?S.style.height=v+"px":S.style.height=v-this.borderWidthB+"px",S.style.marginLeft=this.spec.blR?this.spec.blR-this.borderWidthL+"px":"0",S.style.borderBottom=this.borderStringB;if(this.backgroundImage){var T=this.spec.blR?this.backgroundPosX+this.borderWidthL-v+"px ":this.backgroundPosX+"px ";S.style.backgroundPosition=T+(this.backgroundPosY-A-this.borderWidth+v)+"px"}this.bottomContainer.appendChild(S)}}}this.contentContainer.style.position="absolute",this.contentContainer.className="autoPadDiv",this.contentContainer.style.left=this.borderWidthL+"px",this.contentContainer.style.paddingTop=this.topPadding+"px",this.contentContainer.style.top=this.borderWidth+"px",this.contentContainer.style.paddingLeft=this.leftPadding+"px",this.contentContainer.style.paddingRight=this.rightPadding+"px",z=B,curvyBrowser.quirksMode||(z-=this.leftPadding+this.rightPadding),this.contentContainer.style.width=z+"px",this.contentContainer.style.textAlign=curvyBrowser.get_style(this.box,"textAlign"),this.box.style.textAlign="left",this.box.appendChild(this.contentContainer),a&&(a.style.display="none")},this.backgroundImage&&(m=this.backgroundCheck(m),n=this.backgroundCheck(n),this.backgroundObject&&(this.backgroundObject.holdingElement=this,this.dispatch=this.applyCorners,this.applyCorners=function(){this.backgroundObject.complete?this.dispatch():this.backgroundObject.onload=new Function("curvyObject.dispatch(this.holdingElement);")}))}function addEvent(a,b,c,d){return a.addEventListener?(a.addEventListener(b,c,d),!0):a.attachEvent?a.attachEvent("on"+b,c):(a["on"+b]=c,!1)}var curvyBrowser=new browserdetect;if(curvyBrowser.isIE)try{document.execCommand("BackgroundImageCache",!1,!0)}catch(e){}curvyCnrSpec.prototype.setcorner=function(a,b,c,d){a?(propname=a.charAt(0)+b.charAt(0),this[propname+"R"]=parseInt(c),this[propname+"u"]=d):(this.tlR=this.trR=this.blR=this.brR=parseInt(c),this.tlu=this.tru=this.blu=this.bru=d)},curvyCnrSpec.prototype.get=function(a){if(/^(t|b)(l|r)(R|u)$/.test(a))return this[a];if(/^(t|b)(l|r)Ru$/.test(a)){var b=a.charAt(0)+a.charAt(1);return this[b+"R"]+this[b+"u"]}if(/^(t|b)Ru?$/.test(a)){var c=a.charAt(0);c+=this[c+"lR"]>this[c+"rR"]?"l":"r";var d=this[c+"R"];return a.length===3&&a.charAt(2)==="u"&&(d+=this[c="u"]),d}throw new Error("Don't recognize property "+a)},curvyCnrSpec.prototype.radiusdiff=function(a){if(a!=="t"&&a!=="b")throw new Error("Param must be 't' or 'b'");return Math.abs(this[a+"lR"]-this[a+"rR"])},curvyCnrSpec.prototype.setfrom=function(a){this.tlu=this.tru=this.blu=this.bru="px","tl"in a&&(this.tlR=a.tl.radius),"tr"in a&&(this.trR=a.tr.radius),"bl"in a&&(this.blR=a.bl.radius),"br"in a&&(this.brR=a.br.radius),"antiAlias"in a&&(this.antiAlias=a.antiAlias)},curvyCnrSpec.prototype.cloneOn=function(a){var b=["tl","tr","bl","br"],c=0,d,e;for(d in b)if(!isNaN(d)){e=this[b[d]+"u"];if(e!==""&&e!=="px"){c=new curvyCnrSpec;break}}if(!c)c=this;else{var f,g,h=curvyBrowser.get_style(a,"left");for(d in b)if(!isNaN(d)){f=b[d],e=this[f+"u"],g=this[f+"R"];if(e!=="px"){var h=a.style.left;a.style.left=g+e,g=a.style.pixelLeft,a.style.left=h}c[f+"R"]=g,c[f+"u"]="px"}a.style.left=h}return c},curvyCnrSpec.prototype.radiusSum=function(a){if(a!=="t"&&a!=="b")throw new Error("Param must be 't' or 'b'");return this[a+"lR"]+this[a+"rR"]},curvyCnrSpec.prototype.radiusCount=function(a){var b=0;return this[a+"lR"]&&++b,this[a+"rR"]&&++b,b},curvyCnrSpec.prototype.cornerNames=function(){var a=[];return this.tlR&&a.push("tl"),this.trR&&a.push("tr"),this.blR&&a.push("bl"),this.brR&&a.push("br"),a},operasheet.contains_border_radius=function(a){return/border-((top|bottom)-(left|right)-)?radius/.test(document.styleSheets.item(a).ownerNode.text)},curvyCorners.prototype.applyCornersToAll=function(){curvyCorners.alert("This function is now redundant. Just call curvyCorners(). See documentation.")},curvyCorners.redraw=function(){if(!curvyBrowser.isOp&&!curvyBrowser.isIE)return;if(!curvyCorners.redrawList)throw curvyCorners.newError("curvyCorners.redraw() has nothing to redraw.");var a=curvyCorners.bock_redraw;curvyCorners.block_redraw=!0;for(var b in curvyCorners.redrawList){if(isNaN(b))continue;var c=curvyCorners.redrawList[b];if(!c.node.clientWidth)continue;var d=c.copy.cloneNode(!1);for(var e=c.node.firstChild;e!=null;e=e.nextSibling)if(e.className==="autoPadDiv")break;if(!e){curvyCorners.alert("Couldn't find autoPad DIV");break}c.node.parentNode.replaceChild(d,c.node);while(e.firstChild)d.appendChild(e.removeChild(e.firstChild));c=new curvyObject(c.spec,c.node=d),c.applyCorners()}curvyCorners.block_redraw=a},curvyCorners.adjust=function(obj,prop,newval){if(curvyBrowser.isOp||curvyBrowser.isIE){if(!curvyCorners.redrawList)throw curvyCorners.newError("curvyCorners.adjust() has nothing to adjust.");var i,j=curvyCorners.redrawList.length;for(i=0;i<j;++i)if(curvyCorners.redrawList[i].node===obj)break;if(i===j)throw curvyCorners.newError("Object not redrawable");obj=curvyCorners.redrawList[i].copy}prop.indexOf(".")===-1?obj[prop]=newval:eval("obj."+prop+"='"+newval+"'")},curvyCorners.handleWinResize=function(){curvyCorners.block_redraw||curvyCorners.redraw()},curvyCorners.setWinResize=function(a){curvyCorners.block_redraw=!a},curvyCorners.newError=function(a){return new Error("curvyCorners Error:\n"+a)},curvyCorners.alert=function(a){(typeof curvyCornersVerbose=="undefined"||curvyCornersVerbose)&&alert(a)},curvyObject.prototype.backgroundCheck=function(a){if(a==="top"||a==="left"||parseInt(a)===0)return 0;if(!/^[-\d.]+px$/.test(a)&&!this.backgroundObject){this.backgroundObject=new Image;var b=function(a){var b=/url\("?([^'"]+)"?\)/.exec(a);return b?b[1]:a};this.backgroundObject.src=b(this.backgroundImage)}return a},curvyObject.dispatch=function(a){if(!("dispatch"in a))throw a.newError("No dispatch function");a.dispatch()},curvyObject.prototype.drawPixel=function(a,b,c,d,e,f,g,h){var i=document.createElement("div");i.style.height=e+"px",i.style.width="1px",i.style.position="absolute",i.style.fontSize="1px",i.style.overflow="hidden";var j=this.spec.get("tR");i.style.backgroundColor=c,g&&this.backgroundImage!=""&&(i.style.backgroundImage=this.backgroundImage,i.style.backgroundPosition="-"+(this.boxWidth-(h-a)+this.borderWidth)+"px -"+(this.boxHeight+j+b-this.borderWidth)+"px"),d!=100&&curvyObject.setOpacity(i,d),i.style.top=b+"px",i.style.left=a+"px",f.appendChild(i)},curvyObject.prototype.fillerWidth=function(a){var b=curvyBrowser.quirksMode?0:this.spec.radiusCount(a)*this.borderWidthL;return this.boxWidth-this.spec.radiusSum(a)+b+"px"},curvyObject.prototype.errmsg=function(a,b){var c="\ntag: "+this.box.tagName;this.box.id&&(c+="\nid: "+this.box.id),this.box.className&&(c+="\nclass: "+this.box.className);var d;return(d=this.box.parentNode)===null?c+="\n(box has no parent)":(c+="\nParent tag: "+d.tagName,d.id&&(c+="\nParent ID: "+d.id),d.className&&(c+="\nParent class: "+d.className)),b===undefined&&(b="warning"),"curvyObject "+b+":\n"+a+c},curvyObject.prototype.newError=function(a){return new Error(this.errmsg(a,"exception"))},curvyObject.IntToHex=function(a){var b=["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"];return b[a>>>4]+""+b[a&15]},curvyObject.BlendColour=function(a,b,c){if(a==="transparent"||b==="transparent")throw this.newError("Cannot blend with transparent");a.charAt(0)!=="#"&&(a=curvyObject.format_colour(a)),b.charAt(0)!=="#"&&(b=curvyObject.format_colour(b));var d=parseInt(a.substr(1,2),16),e=parseInt(a.substr(3,2),16),f=parseInt(a.substr(5,2),16),g=parseInt(b.substr(1,2),16),h=parseInt(b.substr(3,2),16),i=parseInt(b.substr(5,2),16);if(c>1||c<0)c=1;var j=Math.round(d*c+g*(1-c));j>255&&(j=255),j<0&&(j=0);var k=Math.round(e*c+h*(1-c));k>255&&(k=255),k<0&&(k=0);var l=Math.round(f*c+i*(1-c));return l>255&&(l=255),l<0&&(l=0),"#"+curvyObject.IntToHex(j)+curvyObject.IntToHex(k)+curvyObject.IntToHex(l)},curvyObject.pixelFraction=function(a,b,c){var d,e=c*c,f=new Array(2),g=new Array(2),h=0,i="",j=Math.sqrt(e-Math.pow(a,2));j>=b&&j<b+1&&(i="Left",f[h]=0,g[h]=j-b,++h),j=Math.sqrt(e-Math.pow(b+1,2)),j>=a&&j<a+1&&(i+="Top",f[h]=j-a,g[h]=1,++h),j=Math.sqrt(e-Math.pow(a+1,2)),j>=b&&j<b+1&&(i+="Right",f[h]=1,g[h]=j-b,++h),j=Math.sqrt(e-Math.pow(b,2)),j>=a&&j<a+1&&(i+="Bottom",f[h]=j-a,g[h]=0);switch(i){case"LeftRight":d=Math.min(g[0],g[1])+(Math.max(g[0],g[1])-Math.min(g[0],g[1]))/2;break;case"TopRight":d=1-(1-f[0])*(1-g[1])/2;break;case"TopBottom":d=Math.min(f[0],f[1])+(Math.max(f[0],f[1])-Math.min(f[0],f[1]))/2;break;case"LeftBottom":d=g[0]*f[1]/2;break;default:d=1}return d},curvyObject.rgb2Array=function(a){var b=a.substring(4,a.indexOf(")"));return b.split(", ")},curvyObject.rgb2Hex=function(a){try{var b=curvyObject.rgb2Array(a),c=parseInt(b[0]),d=parseInt(b[1]),e=parseInt(b[2]),f="#"+curvyObject.IntToHex(c)+curvyObject.IntToHex(d)+curvyObject.IntToHex(e)}catch(g){var h="getMessage"in g?g.getMessage():g.message;throw new Error("Error ("+h+") converting RGB value to Hex in rgb2Hex")}return f},curvyObject.setOpacity=function(a,b){b=b==100?99.999:b;if(curvyBrowser.isSafari&&a.tagName!="IFRAME"){var c=curvyObject.rgb2Array(a.style.backgroundColor),d=parseInt(c[0]),e=parseInt(c[1]),f=parseInt(c[2]);a.style.backgroundColor="rgba("+d+", "+e+", "+f+", "+b/100+")"}else typeof a.style.opacity!="undefined"?a.style.opacity=b/100:typeof a.style.MozOpacity!="undefined"?a.style.MozOpacity=b/100:typeof a.style.filter!="undefined"?a.style.filter="alpha(opacity="+b+")":typeof a.style.KHTMLOpacity!="undefined"&&(a.style.KHTMLOpacity=b/100)},curvyObject.getComputedColour=function(a){var b=document.createElement("DIV");b.style.backgroundColor=a,document.body.appendChild(b);if(window.getComputedStyle){var c=document.defaultView.getComputedStyle(b,null).getPropertyValue("background-color");return b.parentNode.removeChild(b),c.substr(0,3)==="rgb"&&(c=curvyObject.rgb2Hex(c)),c}var d=document.body.createTextRange();d.moveToElementText(b),d.execCommand("ForeColor",!1,a);var e=d.queryCommandValue("ForeColor"),f="rgb("+(e&255)+", "+((e&65280)>>8)+", "+((e&16711680)>>16)+")";return b.parentNode.removeChild(b),d=null,curvyObject.rgb2Hex(f)},curvyObject.format_colour=function(a){return a!=""&&a!="transparent"&&(a.substr(0,3)==="rgb"?a=curvyObject.rgb2Hex(a):a.charAt(0)!=="#"?a=curvyObject.getComputedColour(a):a.length===4&&(a="#"+a.charAt(1)+a.charAt(1)+a.charAt(2)+a.charAt(2)+a.charAt(3)+a.charAt(3))),a},curvyCorners.getElementsByClass=function(a,b){var c=new Array;b===undefined&&(b=document),a=a.split(".");var d="*";a.length===1?(d=a[0],a=!1):(a[0]&&(d=a[0]),a=a[1]);var e,f,g;if(d.charAt(0)==="#")f=document.getElementById(d.substr(1)),f&&c.push(f);else{f=b.getElementsByTagName(d),g=f.length;if(a){var h=new RegExp("(^|\\s)"+a+"(\\s|$)");for(e=0;e<g;++e)h.test(f[e].className)&&c.push(f[e])}else for(e=0;e<g;++e)c.push(f[e])}return c};if(curvyBrowser.isMoz||curvyBrowser.isWebKit)var curvyCornersNoAutoScan=!0;else curvyCorners.scanStyles=function(){function a(a){var b=/^[\d.]+(\w+)$/.exec(a);return b[1]}var b,c,d;if(curvyBrowser.isIE){function e(b){var c=b.style;if(curvyBrowser.ieVer>6)var d=c["-webkit-border-radius"]||0,e=c["-webkit-border-top-right-radius"]||0,f=c["-webkit-border-top-left-radius"]||0,g=c["-webkit-border-bottom-right-radius"]||0,h=c["-webkit-border-bottom-left-radius"]||0;else var d=c["webkit-border-radius"]||0,e=c["webkit-border-top-right-radius"]||0,f=c["webkit-border-top-left-radius"]||0,g=c["webkit-border-bottom-right-radius"]||0,h=c["webkit-border-bottom-left-radius"]||0;if(d||f||e||g||h){var i=new curvyCnrSpec(b.selectorText);d?i.setcorner(null,null,parseInt(d),a(d)):(e&&i.setcorner("t","r",parseInt(e),a(e)),f&&i.setcorner("t","l",parseInt(f),a(f)),h&&i.setcorner("b","l",parseInt(h),a(h)),g&&i.setcorner("b","r",parseInt(g),a(g))),curvyCorners(i)}}for(b=0;b<document.styleSheets.length;++b){if(document.styleSheets[b].imports)for(c=0;c<document.styleSheets[b].imports.length;++c)for(d=0;d<document.styleSheets[b].imports[c].rules.length;++d)e(document.styleSheets[b].imports[c].rules[d]);for(c=0;c<document.styleSheets[b].rules.length;++c)e(document.styleSheets[b].rules[c])}}else if(curvyBrowser.isOp){for(b=0;b<document.styleSheets.length;++b)if(operasheet.contains_border_radius(b)){d=new operasheet(b);for(c in d.rules)isNaN(c)||curvyCorners(d.rules[c])}}else curvyCorners.alert("Scanstyles does nothing in Webkit/Firefox")},curvyCorners.init=function(){if(arguments.callee.done)return;arguments.callee.done=!0,curvyBrowser.isWebKit&&curvyCorners.init.timer&&(clearInterval(curvyCorners.init.timer),curvyCorners.init.timer=null),curvyCorners.scanStyles()};if(typeof curvyCornersNoAutoScan=="undefined"||curvyCornersNoAutoScan===!1)curvyBrowser.isOp?document.addEventListener("DOMContentLoaded",curvyCorners.init,!1):addEvent(window,"load",curvyCorners.init,!1);