package com.dktechtest.memochat

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.ContextMenu
import android.view.MenuInflater
import android.view.View
import android.widget.ImageView
import androidx.activity.viewModels

import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.LinearLayoutManager
import com.dktechtest.memochat.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    private val viewModel: ViewModel by viewModels()
    private val sharedKey: String = "Favorite"
    private lateinit var prefs:PreferenceUtil
    private var checked: Boolean? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val binding = DataBindingUtil.setContentView<ActivityMainBinding>(this, R.layout.activity_main)

        prefs = PreferenceUtil(applicationContext)
        checked = prefs.getBoolean(sharedKey, false)
        val mAdapter = MemoAdapter(this, viewModel)

        binding.recyclerview.apply {
            adapter = mAdapter
            layoutManager = LinearLayoutManager(applicationContext)
        }

        favoriteChecked(binding.favorite, mAdapter)
        binding.favorite.setOnClickListener(View.OnClickListener {
            checked = !checked!!
            favoriteChecked(binding.favorite, mAdapter)
            binding.recyclerview.smoothScrollToPosition(mAdapter.itemCount)
        })

        binding.buttonSend.setOnClickListener{
            // 빈 값은 전송 안함
            if (binding.editMessage.text.trim().isEmpty()) {
            } else if (binding.editMessage.text.trim()
                    .toString() == "해골" || binding.editMessage.text.trim().toString()
                    .lowercase() == "skelleton"
            ) {
                viewModel.profileData(
                    ViewModel.CallProfile.service.getProfiles(),
                    checked!!
                )
            } else {
                viewModel.insert(
                    Entity(0, checked!!, binding.editMessage.text.toString(), null)
                )
            }
            binding.editMessage.text.clear()
            binding.recyclerview.smoothScrollToPosition(mAdapter.itemCount)
        }

        registerForContextMenu(binding.recyclerview)
    }

    override fun onCreateContextMenu(menu: ContextMenu, v: View, menuInfo: ContextMenu.ContextMenuInfo) {
        super.onCreateContextMenu(menu, v, menuInfo)
        var inflater: MenuInflater = menuInflater
        inflater.inflate(R.menu.context_menu, menu)
    }

    private fun favoriteChecked(imageView: ImageView, mAdapter: MemoAdapter) {
        if(viewModel.allMemos.hasObservers()) {
            viewModel.allMemos.removeObservers(this)
        }
        if(viewModel.favoriteMemos.hasObservers()) {
            viewModel.favoriteMemos.removeObservers(this)
        }
        prefs.setBoolean(sharedKey, checked!!)
        if (checked!!) {
            imageView.setImageResource(R.drawable.ic_baseline_favorite_32)
            viewModel.favoriteMemos.observe(this) { memos ->
                memos?.let { mAdapter.setFavoriteMemos(it) }
            }
        } else {
            imageView.setImageResource(R.drawable.ic_baseline_favorite_border_32)
            viewModel.allMemos.observe(this) { memos ->
                memos?.let { mAdapter.setAllMemos(it) }
            }
        }
    }
}