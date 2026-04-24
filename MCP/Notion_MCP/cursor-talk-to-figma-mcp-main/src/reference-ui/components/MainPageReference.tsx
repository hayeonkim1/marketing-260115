import React from "react";
import { ProductCard } from "./ProductCard";

export function MainPageReference() {
  return (
    <main className="w-[402px] rounded-[32px] bg-ref-bg px-5 pb-8 pt-6">
      <section className="rounded-[22px] bg-ref-lime p-5">
        <div className="mb-3 flex justify-end gap-2 text-ref-text-primary">
          <div className="h-6 w-6 rounded-full border border-black/20" />
          <div className="h-6 w-6 rounded-full border border-black/20" />
          <div className="h-6 w-6 rounded-full border border-black/20" />
        </div>
        <p className="text-[38px] leading-[1.05] text-ref-text-primary">나는 아침형vs저녁형?</p>
        <p className="text-[38px] font-bold leading-[1.05] text-ref-text-primary">언제든 혜택은 계속된다!</p>
      </section>

      <section className="mt-3 rounded-full border border-ref-purple/40 bg-ref-surface px-4 py-3">
        <div className="flex items-center justify-between">
          <p className="text-[32px] font-bold text-ref-purple">9 포켓몬</p>
          <div className="h-8 w-8 rounded-full border border-ref-text-secondary/50" />
        </div>
      </section>

      <section className="mt-4 rounded-ref bg-ref-surface p-3">
        <p className="text-lg font-bold text-ref-text-primary">약과는 '명품'을 싸게 산다</p>
        <p className="mt-1 text-sm text-ref-text-secondary">이젠 위글리팝업에서 명품까지 만나보세요</p>
      </section>

      <section className="mt-4 rounded-[22px] bg-[#0B2B57] p-4 text-white">
        <p className="text-3xl font-bold">두산베어스 승리를 위하여!</p>
        <p className="mt-2 text-xl opacity-90">Time to MOVE ON</p>
      </section>

      <section className="mt-6 flex gap-3">
        <ProductCard title="연세우유 크림빵" subtitle="한정 수량" price="2,900원" badge="행사" />
        <ProductCard title="아메리카노 1+1" subtitle="오늘만 특가" price="1,500원" />
      </section>
    </main>
  );
}
