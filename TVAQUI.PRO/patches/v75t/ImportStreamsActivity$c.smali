.class Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;
.super Landroid/os/AsyncTask;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "StaticFieldLeak"
    }
.end annotation

.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b(Ljava/util/List;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "c"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Ljava/lang/String;",
        "Ljava/lang/Integer;",
        "Ljava/lang/Boolean;",
        ">;"
    }
.end annotation


# instance fields
.field a:Landroid/content/Context;

.field final synthetic b:Ljava/util/List;

.field final synthetic c:Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;


# direct methods
.method constructor <init>(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;Landroid/content/Context;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")V"
        }
    .end annotation

    iput-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->c:Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;

    iput-object p3, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->b:Ljava/util/List;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    const/4 p1, 0x0

    iput-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->a:Landroid/content/Context;

    iput-object p2, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->a:Landroid/content/Context;

    return-void
.end method


# virtual methods
.method protected varargs a([Ljava/lang/String;)Ljava/lang/Boolean;
    .locals 3

    const/4 p1, 0x1

    new-array v0, p1, [Ljava/lang/Integer;

    const/4 v1, 0x0

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->publishProgress([Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->c:Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;

    invoke-static {v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;)Lcom/ftgtv/ftgiptvbox/b/b/k;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->c:Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;

    invoke-static {v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;)Lcom/ftgtv/ftgiptvbox/b/b/k;

    move-result-object v0

    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->b:Ljava/util/List;

    check-cast v1, Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Lcom/ftgtv/ftgiptvbox/b/b/k;->b(Ljava/util/ArrayList;)V

    :cond_0
    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    return-object p1
.end method

.method protected a(Ljava/lang/Boolean;)V
    .locals 5

    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->c:Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;

    invoke-static {p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;)Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->c:Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;

    invoke-static {v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;)Lcom/ftgtv/ftgiptvbox/b/b/k;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->c:Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;

    invoke-static {v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;)Lcom/ftgtv/ftgiptvbox/b/b/k;

    move-result-object v0

    const-string v1, "seriesstreams"

    const-string v2, "8"

    const-string v3, "Finished"

    invoke-virtual {v0, v1, v2, v3, p1}, Lcom/ftgtv/ftgiptvbox/b/b/k;->b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    :cond_0
    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->c:Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;

    invoke-static {p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;)I

    move-result p1

    if-lez p1, :cond_1

    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->c:Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;

    iget-object p1, p1, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->c:Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;

    invoke-virtual {v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f11028b

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lcom/ftgtv/ftgiptvbox/miscelleneious/b/d;->a(Landroid/content/Context;Ljava/lang/String;)V

    :cond_1
    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->c:Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;

    if-eqz v0, :cond_2

    invoke-static {v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;)I

    move-result v1

    if-gtz v1, :cond_2

    :try_start_0
    const-string v1, "tvaqui_sync"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "last_full_sync"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    invoke-interface {v1, v2, v3, v4}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "loginPrefs"

    const/4 v3, 0x0

    invoke-virtual {v0, v2, v3}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v2

    const-string v3, "username"

    const-string v4, ""

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "last_full_sync_user"

    invoke-interface {v1, v3, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->commit()Z

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v1

    :cond_2
    :goto_0
    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->c:Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;

    iget-object p1, p1, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    if-eqz p1, :cond_8

    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->c:Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;

    invoke-virtual {p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object p1

    const-string v0, "redirect_live_tv"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->c:Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;

    invoke-virtual {p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b()V

    new-instance p1, Landroid/content/Intent;

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->c:Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;

    iget-object v0, v0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    const-class v1, Lcom/ftgtv/ftgiptvbox/view/activity/LiveActivityNewFlow;

    invoke-direct {p1, v0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    :goto_1
    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->c:Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;

    invoke-virtual {v0, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->startActivity(Landroid/content/Intent;)V

    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->c:Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;

    invoke-virtual {p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->finish()V

    return-void

    :cond_3
    const-string v0, "redirect_vod"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->c:Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;

    invoke-virtual {p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b()V

    new-instance p1, Landroid/content/Intent;

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->c:Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;

    iget-object v0, v0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    const-class v1, Lcom/ftgtv/ftgiptvbox/view/activity/VodActivityNewFlow;

    invoke-direct {p1, v0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    goto :goto_1

    :cond_4
    const-string v0, "redirect_catchup"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->c:Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;

    invoke-virtual {p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b()V

    new-instance p1, Landroid/content/Intent;

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->c:Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;

    iget-object v0, v0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    const-class v1, Lcom/ftgtv/ftgiptvbox/view/activity/TVArchiveActivityNewFlow;

    invoke-direct {p1, v0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    goto :goto_1

    :cond_5
    const-string v0, "redirect_series"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->c:Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;

    invoke-virtual {p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b()V

    new-instance p1, Landroid/content/Intent;

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->c:Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;

    iget-object v0, v0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    const-class v1, Lcom/ftgtv/ftgiptvbox/view/activity/SeriesActivtyNewFlow;

    invoke-direct {p1, v0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    goto :goto_1

    :cond_6
    const-string v0, "redirect_live_tv_epg_expired"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_7

    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->c:Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;

    invoke-virtual {p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b()V

    new-instance p1, Landroid/content/Intent;

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->c:Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;

    iget-object v0, v0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    const-class v1, Lcom/ftgtv/ftgiptvbox/view/activity/ImportEPGActivity;

    invoke-direct {p1, v0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v0, "redirect_live_tv_epg_expired"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    goto :goto_1

    :cond_7
    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->c:Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;

    invoke-virtual {p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b()V

    new-instance p1, Landroid/content/Intent;

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->c:Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;

    iget-object v0, v0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    const-class v1, Lcom/ftgtv/ftgiptvbox/view/activity/NewDashboardActivity;

    invoke-direct {p1, v0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    goto/16 :goto_1

    :cond_8
    return-void
.end method

.method protected varargs a([Ljava/lang/Integer;)V
    .locals 0

    return-void
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Ljava/lang/String;

    invoke-virtual {p0, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->a([Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object p1

    return-object p1
.end method

.method protected synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/lang/Boolean;

    invoke-virtual {p0, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->a(Ljava/lang/Boolean;)V

    return-void
.end method

.method protected onPreExecute()V
    .locals 0

    return-void
.end method

.method protected synthetic onProgressUpdate([Ljava/lang/Object;)V
    .locals 0

    check-cast p1, [Ljava/lang/Integer;

    invoke-virtual {p0, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->a([Ljava/lang/Integer;)V

    return-void
.end method
