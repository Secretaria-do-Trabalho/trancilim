(function(){
  'use strict';
  if(window.__patrimonioSaveProgressV133) return;
  window.__patrimonioSaveProgressV133=true;

  const nativeAlert=window.alert.bind(window);

  function injectStyle(){
    if(document.getElementById('pat-save-progress-style')) return;
    const style=document.createElement('style');
    style.id='pat-save-progress-style';
    style.textContent=`
      #patSaveProgressBackdrop{position:fixed;inset:0;z-index:25000;display:none;align-items:center;justify-content:center;background:rgba(4,35,32,.52);padding:20px}
      #patSaveProgressBackdrop.open{display:flex}
      #patSaveProgressCard{width:min(430px,100%);background:#fff;border:1px solid #cfe3df;border-radius:22px;box-shadow:0 24px 70px rgba(0,36,31,.30);padding:24px;color:#11364a;text-align:center}
      #patSaveProgressIcon{width:56px;height:56px;border-radius:18px;margin:0 auto 14px;display:grid;place-items:center;background:#e7f8f1;color:#087a43;font-size:27px;font-weight:900}
      #patSaveProgressTitle{margin:0;font-size:22px;line-height:1.2;color:#0c3450}
      #patSaveProgressSubtitle{margin:9px 0 0;color:#577383;font-size:14px;line-height:1.45}
      #patSaveProgressCount{margin:18px 0 8px;font-size:30px;font-weight:950;color:#087a43}
      #patSaveProgressItem{min-height:42px;margin:0;color:#244d60;font-size:14px;line-height:1.45;overflow-wrap:anywhere}
      #patSaveProgressTrack{height:13px;margin-top:17px;border-radius:999px;background:#e6f0ef;overflow:hidden;border:1px solid #d3e5e1}
      #patSaveProgressBar{height:100%;width:0;background:linear-gradient(90deg,#0b8d4c,#27ad70);border-radius:999px;transition:width .22s ease}
      #patSaveProgressOk{display:none;width:100%;margin-top:20px;border:0;border-radius:13px;padding:13px 18px;background:#087f43;color:#fff;font-weight:900;font-size:15px;cursor:pointer}
      #patSaveProgressOk.show{display:block}
      #patSaveProgressCard.done #patSaveProgressIcon{background:#e2f8ea;color:#087a43}
      #patSaveProgressCard.error #patSaveProgressIcon{background:#fff0f2;color:#b4233a}
      #patSaveProgressCard.error #patSaveProgressBar{background:#c43f52}
    `;
    document.head.appendChild(style);
  }

  function ensureModal(){
    injectStyle();
    let back=document.getElementById('patSaveProgressBackdrop');
    if(back) return back;
    back=document.createElement('div');
    back.id='patSaveProgressBackdrop';
    back.innerHTML=`
      <div id="patSaveProgressCard" role="dialog" aria-modal="true" aria-labelledby="patSaveProgressTitle">
        <div id="patSaveProgressIcon">↻</div>
        <h2 id="patSaveProgressTitle">Salvando itens patrimoniais</h2>
        <p id="patSaveProgressSubtitle">Aguarde a confirmação de cada item no banco de dados.</p>
        <div id="patSaveProgressCount">0 de 0</div>
        <p id="patSaveProgressItem">Preparando o cadastro...</p>
        <div id="patSaveProgressTrack"><div id="patSaveProgressBar"></div></div>
        <button id="patSaveProgressOk" type="button">OK — voltar ao cadastro</button>
      </div>`;
    document.body.appendChild(back);
    document.getElementById('patSaveProgressOk').addEventListener('click',()=>{
      back.classList.remove('open');
      document.getElementById('modalCadastro')?.classList.add('hidden');
      try{ window.renderTudo?.(); }catch(e){}
      try{ window.viewById?.('bens'); }catch(e){}
      window.scrollTo({top:0,behavior:'smooth'});
      if(window.__patSaveProgressController) window.__patSaveProgressController.closed=true;
    });
    return back;
  }

  function itemLabel(item,index,total){
    const pat=item?.pat ? `Tombo ${item.pat}` : `Item ${index}`;
    const desc=String(item?.desc||'').trim();
    const curta=desc.length>85?desc.slice(0,82)+'...':desc;
    return `Salvando ${index} de ${total} — ${pat}${curta?' • '+curta:''}`;
  }

  function createController(items){
    const back=ensureModal(),card=document.getElementById('patSaveProgressCard');
    const title=document.getElementById('patSaveProgressTitle');
    const subtitle=document.getElementById('patSaveProgressSubtitle');
    const count=document.getElementById('patSaveProgressCount');
    const item=document.getElementById('patSaveProgressItem');
    const bar=document.getElementById('patSaveProgressBar');
    const icon=document.getElementById('patSaveProgressIcon');
    const ok=document.getElementById('patSaveProgressOk');
    const total=items.length;
    const ctl={current:0,total,completed:false,failed:false,closed:false};

    card.classList.remove('done','error');
    title.textContent='Salvando itens patrimoniais';
    subtitle.textContent='Aguarde a confirmação de cada item no banco de dados.';
    count.textContent=`0 de ${total}`;
    item.textContent=total?itemLabel(items[0],1,total):'Preparando o cadastro...';
    bar.style.width='0%';
    icon.textContent='↻';
    ok.classList.remove('show');
    back.classList.add('open');

    ctl.update=(n)=>{
      n=Math.max(0,Math.min(total,Number(n)||0));
      if(n<ctl.current) return;
      ctl.current=n;
      count.textContent=`${n} de ${total}`;
      bar.style.width=`${total?Math.round(n/total*100):0}%`;
      if(n<total){
        const next=Math.min(n+1,total);
        item.textContent=itemLabel(items[next-1],next,total);
      }else{
        ctl.finish();
      }
    };
    ctl.finish=(message='')=>{
      if(ctl.failed) return;
      ctl.current=total;ctl.completed=true;
      card.classList.add('done');
      title.textContent='Cadastro salvo com sucesso';
      subtitle.textContent='Os itens já foram confirmados no banco de dados.';
      count.textContent=`${total} ${total===1?'item salvo':'itens salvos'}`;
      item.textContent=message || 'Clique em OK para fechar esta janela e voltar ao Cadastro de Bens.';
      bar.style.width='100%';
      icon.textContent='✓';
      ok.classList.add('show');
      const btn=document.getElementById('btnSalvarLoteV100');
      if(btn){btn.disabled=false;btn.textContent='Salvar lote e gerar bens';}
    };
    ctl.fail=(message)=>{
      ctl.failed=true;
      card.classList.add('error');
      title.textContent='Não foi possível concluir o salvamento';
      subtitle.textContent='Os itens já confirmados continuam registrados.';
      count.textContent=`${ctl.current} de ${total}`;
      item.textContent=message || 'Revise a conexão e tente novamente apenas para os itens pendentes.';
      icon.textContent='!';
      ok.textContent='OK — voltar ao cadastro';
      ok.classList.add('show');
      const btn=document.getElementById('btnSalvarLoteV100');
      if(btn){btn.disabled=false;btn.textContent='Salvar lote e gerar bens';}
    };
    ctl.hide=()=>back.classList.remove('open');
    return ctl;
  }

  window.alert=function(message){
    const text=String(message??'');
    const ctl=window.__patSaveProgressController;
    if(/^Lote salvo sem duplicar:/i.test(text)){
      ctl?.finish('Todos os itens do lote foram salvos. Clique em OK para voltar ao cadastro.');
      return;
    }
    if(/^Erro ao salvar lote:/i.test(text) && ctl){
      ctl.fail(text.replace(/^Erro ao salvar lote:\s*/i,''));
      return;
    }
    nativeAlert(text);
  };

  const salvarAnterior=window.salvarLotePatrimonialV100;
  if(typeof salvarAnterior!=='function') return;

  window.salvarLotePatrimonialV100=async function(){
    const rows=[...document.querySelectorAll('#bensBodyV100 tr')].filter(r=>r.querySelector('.bemPat'));
    const items=rows.map(r=>({
      pat:r.querySelector('.bemPat')?.value?.trim()||'',
      desc:r.querySelector('.bemDesc')?.value?.trim()||''
    }));
    const ctl=createController(items);
    window.__patSaveProgressController=ctl;

    const btn=document.getElementById('btnSalvarLoteV100');
    const observer=new MutationObserver(()=>{
      const text=String(btn?.textContent||'');
      const m=text.match(/Salvando\.\.\.\s*(\d+)\s*\/\s*(\d+)/i);
      if(m) ctl.update(Number(m[1]));
    });
    if(btn) observer.observe(btn,{childList:true,characterData:true,subtree:true});

    try{
      await salvarAnterior.apply(this,arguments);
      if(!ctl.completed && !ctl.failed){
        if(ctl.current>=ctl.total && ctl.total) ctl.finish();
        else if(ctl.current===0) ctl.hide();
        else ctl.fail(`O processamento parou após ${ctl.current} de ${ctl.total} itens.`);
      }
    }catch(error){
      console.error(error);
      ctl.fail(error?.message||String(error));
    }finally{
      observer.disconnect();
    }
  };
})();
