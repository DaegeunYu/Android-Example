package com.dktechtest.memochat

import android.app.Application
import android.util.Log
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.LiveData
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class ViewModel(application: Application) : AndroidViewModel(application) {

    private val repository: Repository = Repository(MemoDatebase.getDatabase(application, viewModelScope))

    var allMemos: LiveData<List<Entity>> = repository.allMemos
    var favoriteMemos: LiveData<List<Entity>> = repository.favoriteMemos

    fun insert(entity: Entity) = viewModelScope.launch(Dispatchers.IO) {
        repository.insert(entity)
    }

    fun delete(entity: Entity) = viewModelScope.launch(Dispatchers.IO) {
        repository.delete(entity)
    }

    fun update(entity: Entity) = viewModelScope.launch(Dispatchers.IO) {
        repository.update(entity)
    }

    object CallProfile {
        private const val baseUrl = "https://raw.githubusercontent.com/DaegeunYu/json_data/master/"
        private val retrofit:Retrofit = Retrofit.Builder()
            .baseUrl(baseUrl)
            .addConverterFactory(GsonConverterFactory.create())
            .build()

        val service:ProfileApi = retrofit.create(ProfileApi::class.java)
    }

    fun profileData(callProfile: Call<ProfileData>, checked: Boolean) = viewModelScope.launch(Dispatchers.IO) {
        callProfile.clone().enqueue(object : Callback<ProfileData> {
            override fun onResponse(call: Call<ProfileData>, response: Response<ProfileData>) {
                var name = response.body()!!.results[0].name.title + ". " + response.body()!!.results[0].name.last
                insert(
                    Entity(0, checked, name, response.body()!!.results[0].picture)
                )
            }

            override fun onFailure(call: Call<ProfileData>, e: Throwable) {
                Log.e(call.toString(), e.toString())
            }
        })
    }
}