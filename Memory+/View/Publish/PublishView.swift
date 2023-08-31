//
//  PublishView.swift
//  Memory+
//
//  Created by UltraTempest on 2023/6/29.
//

import SwiftUI

struct PublishView: View {
    var loginState: Int
    @State var currentPage: Int = 0
    @State var postCount: Int = memories.posts.count
    @State private var showLoginAlert = false
    @State var posts = memories.posts
    
    var body: some View {
        ZStack {
            VStack {
                Image("Rectangle 2975")
                    .resizable()
                    .scaledToFill()
                    .frame(height: UIScreen.main.bounds.height * 0.159)
                Spacer()
            }
            VStack {
                if !posts.isEmpty {
                    LazyVStack {
                        ForEach(0...3, id: \.self) { index in
                            if index + 4 * currentPage < postCount {
                                NavigationLink {
                                    PostDetail(loginState: loginState, post: posts[index + 4 * currentPage])
                                } label: {
                                    MemoryRow(memory: posts[index + 4 * currentPage])
                                }
                            }
                        }
                    }
                    .padding(.top)
                } else {
                    Rectangle()
                        .frame(height: 10)
                        .opacity(0)
                    Text("上传属于你的第一份回忆吧！")
                        .font(
                            Font.custom("PingFang SC", size: 24)
                                .weight(.medium)
                        )
                        .foregroundColor(Constants.gray)
                        .padding(.top, UIScreen.main.bounds.height * 0.28)
                }
                Spacer()
            }
            .padding(.bottom, 16.0)
            .background(Constants.bgColor)
            .frame(height: UIScreen.main.bounds.height * 0.751)
            .clipShape(RoundedCorner(radius: 10, corners: [.topLeft, .topRight]))
            VStack {
                Spacer()
                if !posts.isEmpty {
                    HStack {
                        Button {
                            if currentPage > 0 {
                                currentPage -= 1
                            }              
                        } label: {
                            if currentPage == 0 {
                                SmallButton(isDisabled: true, text: "上一页")
                            }
                            else {
                                SmallButton(text: "上一页")
                            }
                        }
                        Spacer()
                        Button {
                            if (currentPage + 1) * 4 < postCount {
                                currentPage += 1
                            }
                        } label: {
                            if (currentPage + 1) * 4 >= postCount {
                                SmallButton(isDisabled: true, text: "下一页")
                            }
                            else {
                                SmallButton(text: "下一页")
                            }
                        }
                    }
                    .padding(.bottom)
                }
                if loginState == 1 {
                    NavigationLink {
                        CreateView()
                    } label: {
                        BigButton(text: "上传我的日常", image: "photo")
                    }
                } else {
                    Button {
                        showLoginAlert = true
                    } label: {
                        BigButton(text: "上传我的日常", image: "photo")
                    }
                    .alert(isPresented: $showLoginAlert) {
                        Alert(title: Text("尚未登录"), message: Text("登录后即可记录属于你的独特回忆。"), dismissButton: .default(Text("OK")))
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.689)
        }
        .background(Constants.bgColor)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationLink {
                    CalendarView(loginState: loginState)
                } label: {
                    Image("calendar")
                        .foregroundColor(.white)
                        .frame(width: 10, height: 20)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("列表")
                    .font(Font
                        .custom("PingFang SC", size: 25)
                        .weight(.medium)
                    )
                    .foregroundColor(.white)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        posts = memories.posts
                        postCount = memories.posts.count
                    }
                } label: {
                    Image("renew")
                        .resizable()
                        .frame(width: 25, height: 22)
                }
            }
        }
//        .onAppear {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                posts = memories.posts
//                postCount = memories.posts.count
//            }
//        }
    }
}

struct PublishView_Previews: PreviewProvider {
    static var previews: some View {
        PublishView(loginState: 0)
    }
}
