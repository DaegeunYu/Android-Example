package com.dktechtest.memochat

import retrofit2.Call
import retrofit2.http.GET

interface ProfileApi {
    @GET("chat_data.json")
    fun getProfiles() : Call<ProfileData>
}