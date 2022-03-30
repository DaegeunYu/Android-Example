package com.dktechtest.memochat

import android.content.Context
import android.view.*
import android.widget.*
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide

class MemoAdapter internal constructor(context: Context, var onDeleteListener: ViewModel) :
    RecyclerView.Adapter<MemoAdapter.ItemViewHolder>() {

    private val inflater: LayoutInflater = LayoutInflater.from(context)
    private val menuInflater: MenuInflater = MenuInflater(context)
    private var memos = emptyList<Entity>()

    inner class ItemViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        var message: TextView = itemView.findViewById(R.id.message)
        var favorite: LinearLayout = itemView.findViewById(R.id.favorite)
        var profile: ImageView = itemView.findViewById(R.id.profile)

        init {
            val clickListener: View.OnLongClickListener = View.OnLongClickListener { view ->
                var memo = memos[adapterPosition]
                var pop = PopupMenu(itemView.context, view)
                menuInflater.inflate(R.menu.context_menu, pop.menu)

                if (memo.favorite) {
                    pop.menu.getItem(pop.menu.size()-1).title = "즐겨찾기 해제"
                } else {
                    pop.menu.getItem(pop.menu.size()-1).title = "즐겨찾기"
                }

                pop.setOnMenuItemClickListener { item ->
                    when (item.itemId) {
                        R.id.delete_message -> {
                            onDeleteListener.delete(memo)
                        }
                        R.id.favorite_message -> {
                            memo.favorite = !memo.favorite
                            onDeleteListener.update(memo)
                        }
                    }
                    false
                }
                pop.show()
                true
            }
            message.setOnLongClickListener(clickListener)
            profile.setOnLongClickListener(clickListener)
        }

    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ItemViewHolder {
        val itemView = inflater.inflate(R.layout.chat_item, parent, false)

        return ItemViewHolder(itemView)
    }

    override fun onBindViewHolder(holder: ItemViewHolder, position: Int) {
        val memo = memos[position]
        holder.message.text = memo.text

        if (memo.profile != null) {
            holder.profile.visibility = View.VISIBLE
            Glide.with(holder.itemView.context)
                .load(memo.profile)
                .into(holder.profile)
        } else {
            holder.profile.visibility = View.GONE
        }

        if (memo.favorite) {
            holder.favorite.visibility = View.VISIBLE
        } else {
            holder.favorite.visibility = View.GONE
        }
    }

    internal fun setAllMemos(memos: List<Entity>) {
        this.memos = memos
        notifyDataSetChanged() // notifyItemInserted, notifyItemRemoved 등으로 사용 할 수 있음
    }

    internal fun setFavoriteMemos(memos: List<Entity>) {
        this.memos = memos
        notifyDataSetChanged()
    }

    override fun getItemCount() = memos.size
}
