/* Service worker: deixa o sistema abrir sem internet.
   Tenta a internet primeiro (para pegar versões novas) e, se falhar, usa a cópia guardada. */
var V='lanchonete-sociedade-v1';
var CORE=['./','./index.html','./manifest.webmanifest','./icon-192.png','./icon-512.png','./icon-maskable-512.png'];

self.addEventListener('install',function(e){
  e.waitUntil(caches.open(V).then(function(c){return c.addAll(CORE)}).then(function(){return self.skipWaiting()}));
});
self.addEventListener('activate',function(e){
  e.waitUntil(caches.keys().then(function(ks){
    return Promise.all(ks.filter(function(k){return k!==V}).map(function(k){return caches.delete(k)}));
  }).then(function(){return self.clients.claim()}));
});
self.addEventListener('fetch',function(e){
  var req=e.request;
  if(req.method!=='GET')return;
  var u=new URL(req.url);
  var fonte=u.hostname==='fonts.googleapis.com'||u.hostname==='fonts.gstatic.com';
  if(u.origin!==location.origin&&!fonte)return;
  e.respondWith(
    fetch(req).then(function(res){
      if(res&&(res.ok||res.type==='opaque')){var copia=res.clone();caches.open(V).then(function(c){c.put(req,copia)})}
      return res;
    }).catch(function(){
      return caches.match(req,{ignoreSearch:true}).then(function(r){
        return r||(req.mode==='navigate'?caches.match('./index.html'):Response.error());
      });
    })
  );
});
