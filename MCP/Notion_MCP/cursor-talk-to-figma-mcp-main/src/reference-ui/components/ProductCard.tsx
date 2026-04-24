import React from "react";

type ProductCardProps = {
  title: string;
  subtitle: string;
  price: string;
  badge?: string;
};

export function ProductCard({ title, subtitle, price, badge }: ProductCardProps) {
  return (
    <article className="w-[178px] rounded-[20px] bg-ref-surface p-3 shadow-ref-card">
      <div className="relative mb-2 h-[122px] rounded-[14px] bg-ref-bg">
        <div className="absolute right-2 top-2 rounded-full bg-ref-purple px-2 py-1 text-[10px] font-semibold text-white">
          장바구니
        </div>
      </div>

      <div className="space-y-1">
        <h3 className="text-sm font-semibold leading-5 text-ref-text-primary">{title}</h3>
        <p className="text-xs text-ref-text-secondary">{subtitle}</p>
      </div>

      <div className="mt-3 flex items-center justify-between">
        <p className="text-base font-bold tracking-tight text-ref-text-primary">{price}</p>
        {badge ? (
          <span className="rounded-full bg-ref-lime px-2 py-1 text-[10px] font-medium text-ref-text-primary">
            {badge}
          </span>
        ) : null}
      </div>
    </article>
  );
}
